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
    
    func getTrackUri(at index: Int)
    func getTrackURL(at index: Int)
    func getAlbumURL()
}

protocol AlbumInteractorOutputProtocol: AnyObject {
    func interactorDidFetchAlbum(_ data: Album)
    func interactorDidGetPlaylist(tracks: [Track], for index: Int)
    func interactorFailedToFetchAlbum()
    
    func interactorDidGetTrackUri(_ uri: String)
    func interactorDidGetURL(_ url: String)
}
