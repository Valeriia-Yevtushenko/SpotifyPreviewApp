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
    func shareURL(_ url: String)
}

protocol SearchViewOutputProtocol: AnyObject {
    func viewDidSelectItem(at index: Int)
    func viewDidTapAddItemToPlaylist(at index: Int)
    func viewDidTapShareItem(at index: Int)
    func viewDidTapDownloadItem(at index: Int)
    func viewDidTapShowItemArtist(at index: Int)
    func viewDidTapShowItemAlbum(at index: Int)
    func viewDidUpdateBySearchText(_ text: String)
}

protocol SearchModuleOutput {
    func runArtistModule(with artistId: String)
    func runAlbumModule(with albumId: String)
    func runListOfPlaylistFlow(for newItemForPlaylist: String)
    func runPlayerFlow(with tracks: [Track], for index: Int)
}
