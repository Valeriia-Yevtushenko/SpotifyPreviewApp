//
//  ServiceManager.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation
import OAuthSwift

protocol ServiceManagerProtocol {
    func authorization() -> AuthorizationServiceProtocol
    func keychain() -> KeychainServiceProtocol
    func network() -> NetworkServiceProtocol
    func urlBuilder() -> URLBuilderProtocol
    func player() -> PlayerServiceProtocol
}

class ServiceManager {
    private let oauth: OAuth2Swift
    private let authorizationService: AuthorizationServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let networkService: NetworkServiceProtocol
    private let urlBuilderService: URLBuilderProtocol
    private let playerService: PlayerServiceProtocol
    
    init() {
        oauth = OAuth2Swift(consumerKey: Client.identifier.rawValue,
                            consumerSecret: Client.secret.rawValue,
                            authorizeUrl: Authorization.url.rawValue,
                            accessTokenUrl: Authorization.accessToken.rawValue,
                            responseType: Authorization.code.rawValue)
        keychainService = KeychainService()
        authorizationService = AuthorizationService(oauth: oauth,
                                                    keychainService: keychainService)
        networkService = NetworkService(client: oauth.client,
                                        authorizationService: authorizationService)
        urlBuilderService = URLBuilder()
        playerService = PlayerService()
    }
}

extension ServiceManager: ServiceManagerProtocol {
    func player() -> PlayerServiceProtocol {
        return playerService
    }
    
    func urlBuilder() -> URLBuilderProtocol {
        return urlBuilderService
    }
    
    func network() -> NetworkServiceProtocol {
        return networkService
    }
    
    func authorization() -> AuthorizationServiceProtocol {
        return authorizationService
    }
    
    func keychain() -> KeychainServiceProtocol {
        return keychainService
    }
}
