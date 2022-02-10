//
//  PlaylistsPresenterProtocol.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation

protocol ListOfPlaylistsViewInputProtocol: AnyObject {
    func setupData(_ model: [CollectionViewCellModel])
    func setupPlaylistsType(_ type: PlaylistType)
    func reloadData()
    func displayLabel(with text: String)
    func displayErrorAlert(with text: String)
}

protocol ListOfPlaylistsViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidTapCreatePlaylist(_ playlist: NewPlaylist)
    func viewSelectedItem(at index: Int)
}

protocol ListOfPlaylistsModuleOutput {
    func runPlaylistModule(with playlistId: String, type: PlaylistType)
}
