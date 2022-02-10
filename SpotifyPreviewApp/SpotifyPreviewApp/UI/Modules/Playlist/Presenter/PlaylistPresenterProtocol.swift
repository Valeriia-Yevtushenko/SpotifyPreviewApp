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
    func updateHeaderView()
    func displayLabel(with text: String)
    func displayErrorAlert(with text: String)
    func showConfirmationToastView()
}

protocol PlaylistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapDeletePlaylist()
    func viewDidTapAddPlaylist()
    func viewDidUpdatePlaylist()
    func viewDidEditPlaylist()
}

protocol PlaylistModuleOutput {
    func backToPlaylists()
    func runEditPlaylistModule(with playlist: Playlist)
}
