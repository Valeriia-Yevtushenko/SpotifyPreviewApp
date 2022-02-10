//
//  PlaylistModuleAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import UIKit

final class PlaylistModuleAssembly {
    func createModule(with playlistId: String, type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (UIViewController, PlaylistViewPresenter) {
        let playlistViewController = PlaylistViewController.instantiate(from: PlaylistViewController.identifier)
        let presenter = PlaylistViewPresenter()
        let interactor = PlaylistInteractor()
        interactor.networkService = serviceManager.network()
        interactor.playlistId = playlistId
        interactor.presenter = presenter
        interactor.playlistType = type
        let dataSource = TrackTableViewDataSource()
        dataSource.delegate = playlistViewController
        presenter.interactor = interactor
        playlistViewController.dataSource = dataSource
        presenter.view = playlistViewController
        playlistViewController.output = presenter
        return (playlistViewController, presenter)
    }
}
