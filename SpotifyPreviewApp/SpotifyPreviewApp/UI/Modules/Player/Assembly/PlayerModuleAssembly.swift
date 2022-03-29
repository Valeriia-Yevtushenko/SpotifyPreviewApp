//
//  PlayerModuleAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import UIKit

final class PlayerModuleAssembly {
    func createModule(with tracks: [Track], for index: Int, serviceManager: ServiceManagerProtocol) -> (UIViewController, PlayerPresenter) {
        let playerViewController = PlayerViewController.instantiate(from: PlayerViewController.identifier)
        let presenter = PlayerPresenter()
        presenter.view = playerViewController
        let interactor = PlayerInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.tracks = tracks
        interactor.index = index
        let playerService = serviceManager.player()
        interactor.playerService = playerService
        playerService.setupDelegate(interactor)
        interactor.networkService = serviceManager.network()
        interactor.urlBuilder = serviceManager.urlBuilder()
        playerViewController.dataSource = TrackTableViewDataSource()
        playerViewController.output = presenter
        return (playerViewController, presenter)
    }
}
