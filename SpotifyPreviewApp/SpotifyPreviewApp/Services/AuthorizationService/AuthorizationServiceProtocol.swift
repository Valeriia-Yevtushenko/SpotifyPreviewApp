//
//  AuthorizationServiceProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import PromiseKit
import UIKit.UIViewController

protocol AuthorizationServiceProtocol {
    func setupAuthorizationDelegate(_ delegate: AuthorizationDelegate)
    func authorization(viewController: UIViewController) -> Promise<Void>
}
