//
//  EditPlaylistInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import Foundation

protocol EditPlaylistInteractorInputProtocol: AnyObject {
    func fetchPlaylist()
    func addPlaylist()
    func deletePlaylist()
}

protocol EditPlaylistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchPlaylist(_ playlist: Playlist, type: PlaylistType)
    func interactorDidDeletePlaylist()
    func interactorDidAddPlaylist()
    func interactorFailedToFetchPlaylist()
    func interactorFailedToDeletePlaylist(_ error: String)
    func interactorFailedToAddPlaylist(_ error: String)
}
