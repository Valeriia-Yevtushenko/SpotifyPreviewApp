//
//  SearchAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 17.05.2021.
//

import UIKit

final class SearchModuleAssembly {    
    func createModule(_ serviceManager: ServiceManagerProtocol) -> (UIViewController, SearchPresenter) {
        let searchViewController = SearchViewController.instantiate(from: SearchViewController.identifier)
        let dataSource = TrackTableViewDataSource()
        let presenter = SearchPresenter()
        searchViewController.dataSource = dataSource
        let interactor = SearchInteractor()
        interactor.networkService = serviceManager.network()
        interactor.presenter = presenter
        presenter.intractor = interactor
        presenter.view = searchViewController
        searchViewController.output = presenter
        return (searchViewController, presenter)
    }
}
