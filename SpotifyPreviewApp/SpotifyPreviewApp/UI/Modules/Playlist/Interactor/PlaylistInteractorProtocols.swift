//
//  PlaylistInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

protocol PlaylistInteractorInputProtocol: AnyObject {
    func fetchPlaylist()
    func deletePlaylist()
}

protocol PlaylistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchPlaylist(_ playlist: Playlist, type: PlaylistType)
    func interactorDidDeletePlaylist()
    func interactorFailedToFetchPlaylist()
    func interactorFailedToDeletePlaylist(_ error: String)
}
