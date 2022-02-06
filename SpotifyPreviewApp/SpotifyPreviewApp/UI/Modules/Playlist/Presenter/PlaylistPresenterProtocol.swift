//
//  Playlist{.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

protocol PlaylistViewInputProtocol: AnyObject {
    func setupPlaylistTracks(_ tracks: [TrackTableViewCellModel])
    func setupPlaylistInfo(image url: String?, name: String?, type: PlaylistType)
    func reloadData()
    func updateHeaderView()
    func displayLabel(with text: String)
    func displayErrorAlert(with text: String)
}

protocol PlaylistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapDeletePlaylist()
    func viewDidUpdate()
    func viewWillDisappear()
}

protocol PlaylistModuleOutput {
    func backToPlaylists()
    func finishedFlow()
}
