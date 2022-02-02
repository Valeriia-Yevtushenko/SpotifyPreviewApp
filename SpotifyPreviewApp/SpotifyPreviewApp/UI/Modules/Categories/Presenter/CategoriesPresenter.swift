//
//  CategoriesPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation

final class CategoriesViewPresenter {
    weak var view: CategoriesViewInputProtocol?
    var interactor: CategoriesInteractorInputProtocol?
}

extension CategoriesViewPresenter: CategoriesViewOutputProtocol {
    func viewDidRefresh() {
        interactor?.fetchCategories()
    }
    
    func viewFetchData() {
        interactor?.fetchCategories()
    }
    
    func viewSelectedItem(at index: Int) {
        interactor?.getCategory(at: index)
    }
}

extension CategoriesViewPresenter: CategoriesInteractorOutputProtocol {
    func interactorDidGetCategory(_ category: String) {
        
    }
    
    func interactorDidFetchCategories(_ data: Categories) {
        guard !data.categories.items.isEmpty  else {
            view?.displayLabel(with: "Unfortunately, the list of categories is empty...")
            return
        }
        
        let viewModel: [CollectionViewCellModel] = data.categories.items.map {
            return CollectionViewCellModel(image: $0.icons[0].url, name: $0.name)
        }
        
        view?.displayLabel(with: "")
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchCategories() {
        view?.displayLabel(with: "Oops, something went wrong...")
    }
}

extension CategoriesViewPresenter: CategoriesModuleInput {
    func runSearchModule(viewController: Presentable) {
        view?.configureSearchController(searchResultsController: viewController)
    }
}
