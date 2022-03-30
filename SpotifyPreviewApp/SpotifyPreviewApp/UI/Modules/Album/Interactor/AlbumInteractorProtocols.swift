//
//  AlbumInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

protocol AlbumInteractorInputProtocol: AnyObject {
    func fetchAlbum()
    func getPlaylist(for index: Int)
    func getPlaylist()
    func getShuffledPlaylist()
}

protocol AlbumInteractorOutputProtocol: AnyObject {
    func interactorDidFetchAlbum(_ data: Album)
    func interactorDidGetPlaylist(tracks: [Track], for index: Int)
    func interactorFailedToFetchAlbum()
}
