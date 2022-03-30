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
    func getPlaylist(for index: Int)
    func getTracks()
    func getShuffledTracks()
    func getPlaylist()
}

protocol PlaylistInteractorOutputProtocol: AnyObject {
    func interactorDidGetPlaylist(tracks: [Track], for index: Int)
    func interactorDidFetchPlaylist(_ playlist: Playlist, type: PlaylistType)
    func interactorDidGetPlaylist(_ playlist: Playlist)
    func interactorDidDeletePlaylist()
    func interactorDidAddPlaylist()
    func interactorFailedToFetchPlaylist()
    func interactorFailedToGetPlaylist()
    func interactorFailedToDeletePlaylist(_ error: String)
    func interactorFailedToAddPlaylist(_ error: String)
}
