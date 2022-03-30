//
//  Playlist{.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

protocol PlaylistViewInputProtocol: AnyObject {
    func setupPlaylist(model: PlaylistViewControllerModel, tracks: [TrackTableViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
    func displayErrorAlert(with text: String)
    func showConfirmationToastView()
}

protocol PlaylistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidRefresh()
    func viewDidSelectItem(at index: Int)
    func viewDidTapDeletePlaylist()
    func viewDidTapAddPlaylist()
    func viewDidEditPlaylist()
    func viewDidTapPlay()
    func viewDidTapShuffle()
}

protocol PlaylistModuleOutput {
    func backToPlaylists()
    func runPlayerFlow(with tracks: [Track], for index: Int)
    func runEditPlaylistModule(with playlist: Playlist)
}
