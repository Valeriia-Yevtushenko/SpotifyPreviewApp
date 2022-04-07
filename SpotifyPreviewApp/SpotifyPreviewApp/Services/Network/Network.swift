//
//  SpotifyClient.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 14.05.2021.
//

import OAuthSwift
import PromiseKit

enum NetworkError: Error {
    case parse
}

class NetworkService {
    private let authorizationService: AuthorizationServiceProtocol
    private let client: OAuthSwiftClient

    init(client: OAuthSwiftClient, authorizationService: AuthorizationServiceProtocol) {
        self.client = client
        self.authorizationService = authorizationService
        configureClient()
    }
}

extension NetworkService: NetworkServiceProtocol {
    func fetch<T: Codable>(_ url: String) -> Promise<T> {
        authorizationService.renewAccessTokenIfNeeded()
        
        return Promise {seal in
            client.get(url) { result in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(T.self, from: response.data) else {
                        seal.reject(NetworkError.parse)
                        return
                    }

                    seal.fulfill(data)
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
    
    func post(data: Data, url: String) -> Promise<Void> {
        authorizationService.renewAccessTokenIfNeeded()
       
        return Promise {seal in
            client.post(url, body: data) { result in
                switch result {
                case .success(_):
                  seal.fulfill_()
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
    
    func post<T: Codable>(data: Data, url: String) -> Promise<T> {
        authorizationService.renewAccessTokenIfNeeded()
       
        return Promise {seal in
            client.post(url, body: data) { result in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(T.self, from: response.data) else {
                        seal.reject(NetworkError.parse)
                        return
                    }

                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func put(data: Data, header: [String: String], url: String) -> Promise<Void> {
        authorizationService.renewAccessTokenIfNeeded()
       
        return Promise {seal in
            client.put(url, headers: header, body: data) { result in
                switch result {
                case .success(_):
                    seal.fulfill_()
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
    
    func put(data: Data, url: String) -> Promise<Void> {
        authorizationService.renewAccessTokenIfNeeded()
       
        return Promise {seal in
            client.put(url, body: data) { result in
                switch result {
                case .success(_):
                    seal.fulfill_()
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
    
    func delete(url: String) -> Promise<Void> {
        authorizationService.renewAccessTokenIfNeeded()
       
        return Promise {seal in
            client.delete(url) { result in
                switch result {
                case .success(_):
                    seal.fulfill_()
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
    
    func delete(data: Data, url: String) -> Promise<Void> {
        authorizationService.renewAccessTokenIfNeeded()
       
        return Promise {seal in
            client.request(url, method: .DELETE, body: data) { result in
                switch result {
                case .success(_):
                    seal.fulfill_()
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
}

private extension NetworkService {
    func configureClient() {
        guard let token = authorizationService.sessionData() else {
            return
        }

        client.credential.oauthToken = token.access
        client.credential.oauthRefreshToken = token.refresh
        client.credential.oauthTokenExpiresAt = token.date

        authorizationService.renewAccessTokenIfNeeded()
    }
}
