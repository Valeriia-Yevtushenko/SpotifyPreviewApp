//
//  CategoriesInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation

protocol CategoriesInteractorInputProtocol: AnyObject {
    func fetchCategories()
    func getCategory(at index: Int)
}

protocol CategoriesInteractorOutputProtocol: AnyObject {
    func interactorDidFetchCategories(_ data: ListOfCategories)
    func interactorFailedToFetchCategories()
    func interactorDidGetCategory(_ category: String)
}
