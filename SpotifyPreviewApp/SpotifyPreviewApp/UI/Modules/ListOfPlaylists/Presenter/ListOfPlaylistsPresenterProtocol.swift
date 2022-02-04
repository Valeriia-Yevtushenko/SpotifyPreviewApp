//
//  PlaylistsPresenterProtocol.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation

protocol ListOfPlaylistsViewInputProtocol: AnyObject {
    func setupData(_ model: [CollectionViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
}

protocol ListOfPlaylistsViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewSelectedItem(at index: Int)
}

protocol ListOfPlaylistsModuleOutput {
    func runPlaylistModule(data: String)
}
