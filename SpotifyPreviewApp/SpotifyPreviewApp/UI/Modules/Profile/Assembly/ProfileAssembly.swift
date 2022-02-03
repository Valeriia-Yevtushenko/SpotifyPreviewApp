//
//  ProfileAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 17.05.2021.
//

import UIKit

final class ProfileModuleAssembly {
    func createModule(_ serviceManager: ServiceManagerProtocol) -> (UIViewController, ProfileViewPresenter) {
        let profileViewController = ProfileViewController.instantiate(from: ProfileViewController.identifier)
        let presenter = ProfileViewPresenter()
        presenter.view = profileViewController
        let dataSource = TableViewDataSource()
        dataSource.delegate = profileViewController
        profileViewController.dataSource = dataSource
        let interactor = ProfileViewInteractor()
        interactor.presenter = presenter
        interactor.networkService = serviceManager.network()
        presenter.interactor = interactor
        profileViewController.output = presenter
        return (profileViewController, presenter)
    }
}
