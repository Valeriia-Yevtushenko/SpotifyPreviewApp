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
    func viewDidTapDeletePlaylist()
    func viewDidTapAddPlaylist()
    func viewDidEditPlaylist()
}

protocol PlaylistModuleOutput {
    func backToPlaylists()
    func runArtistFlow(with identifier: String)
    func runEditPlaylistModule(with playlist: Playlist)
}
