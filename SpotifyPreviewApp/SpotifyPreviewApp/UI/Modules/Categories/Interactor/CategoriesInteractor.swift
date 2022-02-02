//
//  CategoriesInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation
import PromiseKit

final class CategoriesViewInteractor: CategoriesInteractorInputProtocol {
    private var categoriesData: Categories?
    var presenter: CategoriesInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
    
    func fetchCategories() {
        let promise: Promise<Categories> = networkService.fetch(Request.allCategories.rawValue)
        firstly {
            promise
        }.done {data in
            self.categoriesData = data
            self.presenter?.interactorDidFetchCategories(data)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchCategories()
        }
    }
    
    func getCategory(at index: Int) {
        guard let category = categoriesData?.categories.items[index].identifier else {
            return
        }
        
        presenter?.interactorDidGetCategory(category)
    }
}
