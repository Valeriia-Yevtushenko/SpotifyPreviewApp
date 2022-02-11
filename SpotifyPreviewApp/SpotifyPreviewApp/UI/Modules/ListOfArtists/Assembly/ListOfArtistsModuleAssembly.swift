//
//  ListOfArtistsModuleAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

class ListOfArtistsModuleAssembly {
    func createModule(serviceManager: ServiceManagerProtocol) -> (ListOfArtistsViewController, ListOfArtistsPresenter) {
        let listOfArtistsViewController = ListOfArtistsViewController.instantiate(from: ListOfArtistsViewController.identifier)
        let presenter = ListOfArtistsPresenter()
        let interactor = ListOfArtistsIneractor()
        interactor.networkService = serviceManager.network()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = listOfArtistsViewController
        listOfArtistsViewController.output = presenter
        return (listOfArtistsViewController, presenter)
    }
}
