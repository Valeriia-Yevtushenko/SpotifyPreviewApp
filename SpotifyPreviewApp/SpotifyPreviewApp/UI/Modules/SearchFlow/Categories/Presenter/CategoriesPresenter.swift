//
//  CategoriesPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation

final class CategoriesPresenter {
    weak var view: CategoriesViewInputProtocol?
    var coordinator: CategoriesModuleOutput?
    var interactor: CategoriesInteractorInputProtocol?
}

extension CategoriesPresenter: CategoriesViewOutputProtocol {
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

extension CategoriesPresenter: CategoriesInteractorOutputProtocol {
    func interactorDidGetCategory(_ category: String) {
        coordinator?.runPlaylistsFlow(category)
    }
    
    func interactorDidFetchCategories(_ data: ListOfCategories) {
        guard !data.categories.items.isEmpty  else {
            view?.displayLabel(with: "Unfortunately, the list of categories is empty.")
            return
        }
        
        let viewModel: [CollectionViewCellModel] = data.categories.items.map {
            return CollectionViewCellModel(image: $0.icons[0].url, name: $0.name)
        }
        
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchCategories() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to reload view")
    }
}

extension CategoriesPresenter: CategoriesModuleInput {
    func runSearchModule(viewController: Presentable) {
        view?.configureSearchController(searchResultsController: viewController)
    }
}
