//
//  AuthorizationModuleAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import UIKit

class AuthorizationModuleAssembly {
    static func create(authorizationService: AuthorizationServiceProtocol) -> (UIViewController, AuthorizationPresenter) {
        let viewController = AuthorizationViewController.instantiate(from: AuthorizationViewController.identifier)
        let presenter = AuthorizationPresenter()
        presenter.view = viewController
        let interactor = AuthorizationInteractor()
        interactor.presenter = presenter
        interactor.authorizationService = authorizationService
        interactor.viewController = viewController
        presenter.interactor = interactor
        viewController.output = presenter
        return (viewController, presenter)
    }
}
