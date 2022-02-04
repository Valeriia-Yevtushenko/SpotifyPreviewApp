//
//  PlaylistsAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit

final class ListOfPlaylistsModuleAssembly {
    func createModule(with type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (UIViewController, ListOfPlaylistsViewPresenter) {
        let playlistsViewController = ListOfPlaylistsViewController.instantiate(from: ListOfPlaylistsViewController.identifier)
        let presenter = ListOfPlaylistsViewPresenter()
        let dataSource = CollectionViewDataSource()
        dataSource.delegate = playlistsViewController
        playlistsViewController.dataSource = dataSource
        let interactor = ListOfPlaylistsViewInteractor()
        interactor.networkService = serviceManager.network()
        interactor.type = type
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = playlistsViewController
        playlistsViewController.output = presenter
        return (playlistsViewController, presenter)
    }
}
