//
//  ArtistModuleAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import UIKit

final class ArtistModuleAssembly {
    func createModule(with artistId: String, status: ArtistStatus, serviceManager: ServiceManagerProtocol) -> (UIViewController, ArtistPresenter) {
        let artistViewController = ArtistViewController.instantiate(from: ArtistViewController.identifier)
        let presenter = ArtistPresenter()
        let dataSource = ArtistTableViewDataSource()
        dataSource.delegate = artistViewController
        artistViewController.dataSource = dataSource
        let interactor = ArtistInteractor()
        interactor.presenter = presenter
        interactor.identifier = artistId
        interactor.networkService = serviceManager.network()
        presenter.interactor = interactor
        presenter.view = artistViewController
        artistViewController.output = presenter
        return (artistViewController, presenter)
    }
}
