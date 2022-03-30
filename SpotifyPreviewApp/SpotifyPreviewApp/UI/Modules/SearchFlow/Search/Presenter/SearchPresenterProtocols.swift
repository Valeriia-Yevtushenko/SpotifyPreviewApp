//
//  PresenterProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation

protocol SearchViewInputProtocol: AnyObject {
    func setupData(_ tracks: [TrackTableViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
}

protocol SearchViewOutputProtocol: AnyObject {
    func viewDidSelectItem(at index: Int)
    func viewDidUpdateBySearchText(_ text: String)
}

protocol SearchModuleOutput {
    func runPlayerFlow(with tracks: [Track], for index: Int)
}
