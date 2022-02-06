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
}

protocol PlaylistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchPlaylist(_ playlist: Playlist, type: PlaylistType)
    func interactorDidDeletePlaylist()
    func interactorDidAddPlaylist()
    func interactorFailedToFetchPlaylist()
    func interactorFailedToDeletePlaylist(_ error: String)
    func interactorFailedToAddPlaylist(_ error: String)
}
