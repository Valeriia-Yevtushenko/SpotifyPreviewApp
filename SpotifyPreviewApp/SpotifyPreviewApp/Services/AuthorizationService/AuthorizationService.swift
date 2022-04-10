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
    private var oauth: OAuth2Swift
    private let keychainService: KeychainServiceProtocol
    private var renewToken = Promise()
    weak var delegate: AuthorizationDelegate?
    
    init(oauth: OAuth2Swift, keychainService: KeychainServiceProtocol) {
        self.oauth = oauth
        self.keychainService = keychainService
    }
}

extension AuthorizationService: AuthorizationServiceProtocol {
    func logOut() {
        keychainService.remove(key: "token")
        
        let consumerKey = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String
        let consumerSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as? String
        oauth = OAuth2Swift(consumerKey: consumerKey ?? "",
                            consumerSecret: consumerSecret ?? "",
                            authorizeUrl: Authorization.url.rawValue,
                            accessTokenUrl: Authorization.accessToken.rawValue,
                            responseType: Authorization.code.rawValue)
    }
    
    func sessionData() -> Token? {
        return keychainService.get(key: "token")
    }
    
    var isAuthorized: Bool {
        guard let _: Token = keychainService.get(key: "token") else {
            return false
        }
        
        return true
    }
    
    func setupAuthorizationDelegate(_ delegate: AuthorizationDelegate) {
        self.delegate = delegate
    }
    
    func authorization(viewController: UIViewController) -> Promise<Void> {
        oauth.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauth)
        oauth.allowMissingStateCheck = true

        return Promise { seal in
            guard let redirectURL = URL(string: Authorization.callbackUrl.rawValue) else {
                return
            }
            
            oauth.authorize(withCallbackURL: redirectURL,
                            scope: Authorization.scope.rawValue,
                            state: Authorization.state.rawValue,
                            codeChallenge: Authorization.codeChallenge.rawValue,
                            codeVerifier: Authorization.codeVerifier.rawValue) { result in
                switch result {
                case .success(let (credential, _, _)):
                    let token = Token(access: credential.oauthToken,
                                              refresh: credential.oauthRefreshToken, date: credential.oauthTokenExpiresAt)
                    self.keychainService.set(token, key: "token")
                    seal.fulfill_()
                case .failure(let error):
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
    }
    
    func renewAccessTokenIfNeeded() -> Promise<Void>? {
        guard !renewToken.isPending, oauth.client.credential.isTokenExpired() else { return nil}
        
        renewToken =  Promise { seal in
            oauth.accessTokenBasicAuthentification = true
            oauth.renewAccessToken(withRefreshToken: oauth.client.credential.oauthRefreshToken) { result in
                switch result {
                case .success(let (credential, _, _)):
                    let token = Token(access: credential.oauthToken,
                                              refresh: credential.oauthRefreshToken, date: credential.oauthTokenExpiresAt)
                    self.keychainService.set(token, key: "token")
                    seal.fulfill_()
                case .failure(let error):
                    self.delegate?.strardAuthorizationRequest()
                    debugPrint(error.description)
                    seal.reject(error)
                }
            }
        }
        
        return renewToken
    }
}
