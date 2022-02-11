//
//  ProfileAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 17.05.2021.
//

import UIKit

final class ProfileModuleAssembly {
    func createModule(_ serviceManager: ServiceManagerProtocol) -> (UIViewController, ProfilePresenter) {
        let profileViewController = ProfileViewController.instantiate(from: ProfileViewController.identifier)
        let presenter = ProfilePresenter()
        presenter.view = profileViewController
        let interactor = ProfileInteractor()
        interactor.presenter = presenter
        interactor.networkService = serviceManager.network()
        presenter.interactor = interactor
        profileViewController.output = presenter
        return (profileViewController, presenter)
    }
}
