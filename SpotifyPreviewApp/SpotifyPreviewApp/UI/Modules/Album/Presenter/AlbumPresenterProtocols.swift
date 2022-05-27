//
//  AlbumPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

protocol AlbumViewInputProtocol: AnyObject {
    func setupData(_ info: AlbumTableViewHeaderFooterViewModel, tracks: [TrackTableViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
    func shareURL(_ url: String)
}

protocol AlbumViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewWillDisappear()
    func viewDidRefresh()
    func viewDidTapShareAlbum()
    func viewSelectedItem(at index: Int)
    func viewDidTapShareItem(at index: Int)
    func viewDidTapAddItemToPlaylist(at index: Int)
    func viewDidTapDownloadItem(at index: Int)
    func viewDidTapPlay()
    func viewDidTapShuffle()
}

protocol AlbumModuleOutput: AnyObject {
    func runPlayerFlow(with tracks: [PlayerItem], for index: Int)
    func runListOfPlaylistFlow(for newItemForPlaylist: String)
    func finishFlow()
}
