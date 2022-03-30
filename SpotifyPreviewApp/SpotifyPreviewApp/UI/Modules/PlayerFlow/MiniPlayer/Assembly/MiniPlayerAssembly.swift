//
//  MiniPlayerAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 29.03.2022.
//

import UIKit

final class MiniPlayerModuleAssembly {
    func createModule(serviceManager: ServiceManagerProtocol) -> (UIViewController, MiniPlayerPresenter) {
        let playerViewController = MiniPlayerViewController.instantiate(from: MiniPlayerViewController.identifier)
        let presenter = MiniPlayerPresenter()
        presenter.view = playerViewController
        let interactor = MiniPlayerInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter
        let playerService = serviceManager.player()
        interactor.playerService = playerService
        playerService.setupDelegate(interactor)
        playerViewController.output = presenter
        return (playerViewController, presenter)
    }
}
