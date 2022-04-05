//
//  SavedTracksPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import Foundation

protocol SavedTracksViewInputProtocol: AnyObject {
    func setupData(_ tracks: [TrackTableViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
    func shareURL(_ url: String)
}

protocol SavedTracksViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapPlay()
    func viewDidTapShuffle()
    func viewDidSelectItem(at index: Int)
    func viewDidTapAddItemToPlaylist(at index: Int)
    func viewDidTapShareItem(at index: Int)
    func viewDidTapShowItemArtist(at index: Int)
    func viewDidTapShowItemAlbum(at index: Int)
}

protocol SavedTracksModuleOutput {
    func runArtistModule(with artistId: String)
    func runAlbumModule(with albumId: String)
    func runListOfPlaylistFlow(for newItemForPlaylist: String)
    func runPlayerFlow(with tracks: [Track], for index: Int)
}
