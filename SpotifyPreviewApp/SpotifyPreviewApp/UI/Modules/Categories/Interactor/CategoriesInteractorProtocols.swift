//
//  CategoriesInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation

protocol CategoriesInteractorInputProtocol: AnyObject {
    func fetchData()
    func getData(at index: Int)
}

protocol CategoriesInteractorOutputProtocol: AnyObject {
    func interactorDidFetchData(_ data: Categories)
    func interactorFailedToFetchData()
    func interactorDidGetData(_ category: String)
}
