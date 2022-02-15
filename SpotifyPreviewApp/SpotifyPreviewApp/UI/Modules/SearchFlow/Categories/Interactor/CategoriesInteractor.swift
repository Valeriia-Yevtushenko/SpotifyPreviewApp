//
//  CategoriesInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation
import PromiseKit

final class CategoriesInteractor: CategoriesInteractorInputProtocol {
    private var listOfCategories: ListOfCategories?
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    weak var presenter: CategoriesInteractorOutputProtocol?
    
    func fetchCategories() {
        let promise: Promise<ListOfCategories> = networkService.fetch(urlBuilder
                                                                        .with(path: .categories)
                                                                        .with(queryItems: ["limit": "50"])
                                                                        .build())
        
        firstly {
            promise
        }.done {data in
            self.listOfCategories = data
            self.presenter?.interactorDidFetchCategories(data)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchCategories()
        }
    }
    
    func getCategory(at index: Int) {
        guard let category = listOfCategories?.categories.items[index].identifier else {
            return
        }
        
        presenter?.interactorDidGetCategory(category)
    }
}
