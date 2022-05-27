//
//  PlaylistsPresenterProtocol.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation

protocol ListOfPlaylistsViewInputProtocol: AnyObject {
    func setupData(_ model: [CollectionViewCellModel], type: PlaylistType)
    func displayLabel(with text: String)
    func showToastView(with text: String)
    func displayErrorAlert(title: String, text: String)
    func reloadData()
}

protocol ListOfPlaylistsViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidRefresh()
    func viewWillAppear()
    func viewDidTapCreatePlaylist(_ playlist: NewPlaylist)
    func viewSelectedItem(at index: Int)
    func viewDismiss()
}

protocol ListOfPlaylistsModuleOutput {
    func dismiss()
    func runPlaylistModule(with playlistId: String, type: PlaylistType)
}
