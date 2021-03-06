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
        let dataSource = SearchTableViewDataSource()
        let presenter = SearchPresenter()
        searchViewController.dataSource = dataSource
        let interactor = SearchInteractor()
        interactor.networkService = serviceManager.network()
        interactor.urlBuilder = serviceManager.urlBuilder()
        interactor.databaseManager = serviceManager.database()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = searchViewController
        searchViewController.output = presenter
        return (searchViewController, presenter)
    }
}
