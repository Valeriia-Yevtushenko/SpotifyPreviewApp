//
//  AlbumModulAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import UIKit

final class AlbumModuleAssembly {
    func createModule(with albumId: String, serviceManager: ServiceManagerProtocol) -> (UIViewController, AlbumPresenter) {
        let albumViewController = AlbumViewController.instantiate(from: AlbumViewController.identifier)
        let presenter = AlbumPresenter()
        let dataSource = AlbumTableViewDataSource()
        dataSource.delegate = albumViewController
        albumViewController.dataSource = dataSource
        let interactor = AlbumInteractor()
        interactor.presenter = presenter
        interactor.identifier = albumId
        interactor.networkService = serviceManager.network()
        interactor.urlBuilder = serviceManager.urlBuilder()
        interactor.databaseManager = serviceManager.database()
        presenter.interactor = interactor
        presenter.view = albumViewController
        albumViewController.output = presenter
        return (albumViewController, presenter)
    }
}
