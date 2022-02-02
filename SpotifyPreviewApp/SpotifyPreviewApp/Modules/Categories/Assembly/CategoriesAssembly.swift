//
//  CategoriesAssembly.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import UIKit

final class CategoriesModuleAssembly {
    func createModule(_ serviceManager: ServiceManagerProtocol) -> (UIViewController, CategoriesViewPresenter) {
        let categoriesViewController = CategoriesViewController.instantiate(from: CategoriesViewController.identifier)
        let presenter = CategoriesViewPresenter()
        let dataSource = CollectionViewDataSource()
        dataSource.categoryDelegate = presenter
        categoriesViewController.dataSource = dataSource
        let interactor = CategoriesViewInteractor()
        interactor.networkService = serviceManager.network()
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router = CategoriesRouter()
        presenter.view = categoriesViewController
        presenter.router = router
        categoriesViewController.output = presenter
        return (categoriesViewController, presenter)
    }
}
