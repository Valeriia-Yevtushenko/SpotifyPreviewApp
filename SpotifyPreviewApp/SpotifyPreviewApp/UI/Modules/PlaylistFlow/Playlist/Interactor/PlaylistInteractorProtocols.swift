//
//  PlaylistInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

protocol PlaylistInteractorInputProtocol: AnyObject {
    func fetchPlaylist()
    func addPlaylist()
    func deletePlaylist()
    func getTrackArtistId(at index: Int)
    func getPlaylist()
}

protocol PlaylistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchPlaylist(_ playlist: Playlist, type: PlaylistType)
    func interactorDidGetPlaylist(_ playlist: Playlist)
    func interactorDidGetPlaylist(_ identifier: String)
    func interactorDidDeletePlaylist()
    func interactorDidAddPlaylist()
    func interactorFailedToFetchPlaylist()
    func interactorFailedToGetPlaylist()
    func interactorFailedToDeletePlaylist(_ error: String)
    func interactorFailedToAddPlaylist(_ error: String)
}
