//
//  AuthorizationServiceProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import PromiseKit
import UIKit.UIViewController

protocol AuthorizationServiceProtocol {
    var isAuthorized: Bool { get }
    func setupAuthorizationDelegate(_ delegate: AuthorizationDelegate)
    func authorization(viewController: UIViewController) -> Promise<Void>
    func renewAccessToken()
    func sessionData() -> Token?
}
