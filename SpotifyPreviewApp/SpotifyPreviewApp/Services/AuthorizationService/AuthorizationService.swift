//
//  AuthorizationService.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation
import OAuthSwift
import PromiseKit

class AuthorizationService {
    private let oauth: OAuth2Swift
    private let storageService: KeychainServiceProtocol
    private var renewToken = Promise()
    weak var delegate: AuthorizationDelegate?
    
    init(oauth: OAuth2Swift, storage: KeychainServiceProtocol) {
        self.oauth = oauth
        self.storageService = storage
    }
}

extension AuthorizationService: AuthorizationServiceProtocol {
    func setupAuthorizationDelegate(_ delegate: AuthorizationDelegate) {
        self.delegate = delegate
    }
    
    func authorization(viewController: UIViewController) -> Promise<Void> {
        oauth.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauth)
        oauth.allowMissingStateCheck = true

        return Promise { seal in
            guard let redirectURL = URL(string: "SpotifyPreviewApp://oauth-callback") else { return }
            oauth.authorize(withCallbackURL: redirectURL, scope: Authorization.scope.rawValue,
                           state: Authorization.state.rawValue, codeChallenge: Authorization.codeChallenge.rawValue,
                                                 codeVerifier: Authorization.codeVerifier.rawValue) { result in
                switch result {
                case .success(let (credential, _, _)):
                    let token = Token(access: credential.oauthToken,
                                              refresh: credential.oauthRefreshToken, date: credential.oauthTokenExpiresAt)
                    self.storageService.set(token, key: "token")
                    seal.resolve(.fulfilled(()))
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
    
    func renewAccessToken() {
        guard !renewToken.isPending else { return }
        
        renewToken =  Promise { seal in
            oauth.accessTokenBasicAuthentification = true
            oauth.renewAccessToken(withRefreshToken: oauth.client.credential.oauthRefreshToken) { result in
                switch result {
                case .success(let (credential, _, _)):
                    let token = Token(access: credential.oauthToken,
                                              refresh: credential.oauthRefreshToken, date: credential.oauthTokenExpiresAt)
                    self.storageService.set(token, key: "token")
                    seal.fulfill_()
                case .failure(let error):
                    self.delegate?.strardAuthorizationRequest()
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
}
