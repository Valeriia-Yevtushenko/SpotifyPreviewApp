//
//  CategoriesPresenterProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation

protocol CategoriesViewInputProtocol: AnyObject {
    func setupData(_ model: [CollectionViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
    func configureSearchController(searchResultsController: Presentable?)
}

protocol CategoriesViewOutputProtocol: AnyObject {
    func viewFetchData()
    func viewSelectedItem(at index: Int)
    func viewDidRefresh()
}

protocol CategoriesModuleOutput {
    func runPlaylistsModule(_ data: String)
}

protocol CategoriesModuleInput {
    func runSearchModule(viewController: Presentable)
}
