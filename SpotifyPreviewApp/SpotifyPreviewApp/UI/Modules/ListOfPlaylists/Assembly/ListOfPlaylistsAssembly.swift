//
//  PlaylistsAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit

final class ListOfPlaylistsModuleAssembly {
    func createModule(with type: PlaylistType, serviceManager: ServiceManagerProtocol) -> (UIViewController, ListOfPlaylistsPresenter) {
        let playlistsViewController = ListOfPlaylistsViewController.instantiate(from: ListOfPlaylistsViewController.identifier)
        let presenter = ListOfPlaylistsPresenter()
        let dataSource = CollectionViewDataSource()
        dataSource.delegate = playlistsViewController
        playlistsViewController.dataSource = dataSource
        let interactor = ListOfPlaylistsInteractor()
        interactor.networkService = serviceManager.network()
        interactor.type = type
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = playlistsViewController
        playlistsViewController.output = presenter
        return (playlistsViewController, presenter)
    }
}
