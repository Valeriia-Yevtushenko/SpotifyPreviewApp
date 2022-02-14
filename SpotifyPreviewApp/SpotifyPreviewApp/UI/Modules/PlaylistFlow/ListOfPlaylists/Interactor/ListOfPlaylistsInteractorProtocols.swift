//
//  PlaylistsInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation

protocol ListOfPlaylistsInteractorInputProtocol: AnyObject {
    func fetchPlaylists()
    func postNewPlaylist(_ playlist: NewPlaylist)
    func getPlaylistId(at index: Int)
}

protocol ListOfPlaylistsInteractorOutputProtocol: AnyObject {
    func interactorDidFetchPlaylists(_ data: Playlists, type: PlaylistType)
    func interactorDidPostNewPlaylist()
    func interactorFailedToFetchPlaylists()
    func interactorFailedToPostPlaylist(_ error: String)
    func interactorDidGetPlaylistId(_ identifier: String, type: PlaylistType)
}
