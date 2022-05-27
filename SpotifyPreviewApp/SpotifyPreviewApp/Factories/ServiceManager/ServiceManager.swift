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
    func database() -> RealmDatabaseService
}

class ServiceManager {
    private let oauth: OAuth2Swift
    private let authorizationService: AuthorizationServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let networkService: NetworkServiceProtocol
    private let urlBuilderService: URLBuilderProtocol
    private let playerService: PlayerServiceProtocol
    private let databaseService: RealmDatabaseService
    
    init() {
        let consumerKey = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String
        let consumerSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as? String
        
        oauth = OAuth2Swift(consumerKey: consumerKey ?? "",
                            consumerSecret: consumerSecret ?? "",
                            authorizeUrl: Authorization.url.rawValue,
                            accessTokenUrl: Authorization.accessToken.rawValue,
                            responseType: "code")
        keychainService = KeychainService()
        authorizationService = AuthorizationService(oauth: oauth,
                                                    keychainService: keychainService)
        networkService = NetworkService(client: oauth.client,
                                        authorizationService: authorizationService)
        urlBuilderService = URLBuilder()
        let player = PlayerService()
        player.configure()
        playerService = player
        databaseService = RealmDatabaseService()
    }
}

extension ServiceManager: ServiceManagerProtocol {
    func database() -> RealmDatabaseService {
        return databaseService
    }
    
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
