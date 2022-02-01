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
    
    func fetchData() {
        let promise: Promise<Categories> = networkService.fetch(Request.allCategories.rawValue)
        
        firstly {
            promise
        }.done {data in
            self.categoriesData = data
            self.presenter?.interactorDidFetchData(data)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchData()
        }
    }
    
    func getData(itemNumber: Int) {
        guard let category = categoriesData?.categories.items[itemNumber].identifier else {
            return
        }
        
        presenter?.interactorDidGetData(category)
    }
}
