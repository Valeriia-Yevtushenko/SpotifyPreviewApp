//
//  ArtistPresenterProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import Foundation

protocol ArtistViewInputProtocol: AnyObject {
    func setupArtistInfo(_ data: ArtistInfoViewModel)
    func setupArtistStatus(_ status: ArtistStatus)
    func reloadData()
    func displayLabel(with text: String)
    func showConfirmationToastView()
    func displayErrorAlert(with text: String)
    func shareURL(_ url: String)
}

protocol ArtistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidRefresh()
    func viewDidTapFollow()
    func viewDidTapUnfollow()
    func viewDidTapShareArtist()
    func viewDidTapOnAlbum(at index: Int)
    func viewDidTapOnTrack(at index: Int)
    func viewDidTapAddItemToPlaylist(at index: Int)
    func viewDidTapShareItem(at index: Int)
    func viewDidTapShowItemAlbum(at index: Int)
    func viewDidTapDownloadItem(at index: Int)
}

protocol ArtistModuleOutput: AnyObject {
    func runListOfPlaylistFlow(for newItemForPlaylist: String)
    func runAlbumFlow(with identifier: String)
    func runPlayerFlow(with tracks: [PlayerItem], for index: Int)
}
