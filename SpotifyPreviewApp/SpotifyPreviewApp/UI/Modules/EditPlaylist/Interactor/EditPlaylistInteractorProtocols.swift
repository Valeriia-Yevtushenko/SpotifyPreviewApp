//
//  EditPlaylistInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import Foundation

protocol EditPlaylistInteractorInputProtocol: AnyObject {
    func getPlaylist()
    func updatePlaylist(with info: NewPlaylist?, image: Data?)
}

protocol EditPlaylistInteractorOutputProtocol: AnyObject {
    func interactorDidGetPlaylist(_ playlist: Playlist)
    func interactorDidUpdatePlaylist()
    func interactorFailedToUpdatePlaylist(_ error: String)
}
