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
    func showConfirmationToastView(with text: String)
    func shareURL(_ url: String)
}

protocol PlaylistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidRefresh()
    func viewDidSelectItem(at index: Int)
    func viewDidTapAddItemToPlaylist(at index: Int)
    func viewDidTapShareItem(at index: Int)
    func viewDidTapDeleteItem(at index: Int)
    func viewDidTapDownloadItem(at index: Int)
    func viewDidTapShowItemArtist(at index: Int)
    func viewDidTapShowItemAlbum(at index: Int)
    func viewDidTapDeletePlaylist()
    func viewDidTapAddPlaylist()
    func viewDidEditPlaylist()
    func viewDidTapPlay()
    func viewDidTapShuffle()
}

protocol PlaylistModuleOutput {
    func backToPlaylists()
    func showListOfPlaylists(for newItemForPlaylist: String)
    func runEditPlaylistModule(with playlist: Playlist)
    func runPlayerFlow(with tracks: [Track], for index: Int)
    func runArtistModule(with artistId: String)
    func runAlbumModule(with albumId: String)
}
