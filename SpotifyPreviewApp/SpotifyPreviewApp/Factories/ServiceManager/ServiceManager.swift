//
//  ServiceManager.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

import Foundation
import OAuthSwift

protocol ServiceManagerProtocol {
    var authorization: AuthorizationServiceProtocol { get }
}

class ServiceManager {
    private let oauth: OAuth2Swift
    private let authorizationService: AuthorizationServiceProtocol
    private let keychainService: KeychainServiceProtocol
    
    init() {
        oauth = OAuth2Swift(consumerKey: Client.identifier.rawValue, consumerSecret: Client.secret.rawValue,
                                    authorizeUrl: Request.authURL.rawValue, accessTokenUrl: Request.accessToken.rawValue,
                                    responseType: Authorization.code.rawValue)
        keychainService = KeychainService()
        authorizationService = AuthorizationService(oauth: oauth, storage: keychainService)
    }
}

extension ServiceManager: ServiceManagerProtocol {
    var authorization: AuthorizationServiceProtocol {
        return AuthorizationService(oauth: oauth, storage: keychainService)
    }
}
