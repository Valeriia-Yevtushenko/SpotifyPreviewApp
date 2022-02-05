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
        dataSource.delegate = categoriesViewController
        categoriesViewController.dataSource = dataSource
        let interactor = CategoriesInteractor()
        interactor.networkService = serviceManager.network()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = categoriesViewController
        categoriesViewController.output = presenter
        return (categoriesViewController, presenter)
    }
}
