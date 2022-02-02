//
//  SpotifyClient.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 14.05.2021.
//

import OAuthSwift
import PromiseKit

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
        if client.credential.isTokenExpired() {
           authorizationService.renewAccessToken()
        }
        
        return Promise {seal in
            client.get(url) { result in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(T.self, from: response.data) else {
                        return
                    }

                    seal.resolve(.fulfilled(data))
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

        if client.credential.isTokenExpired() {
            authorizationService.renewAccessToken()
        }
    }
}