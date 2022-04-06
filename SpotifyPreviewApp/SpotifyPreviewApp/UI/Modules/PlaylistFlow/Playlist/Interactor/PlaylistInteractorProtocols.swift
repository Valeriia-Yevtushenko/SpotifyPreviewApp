//
//  PlaylistInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

protocol PlaylistInteractorInputProtocol: AnyObject {
    func fetchPlaylist()
    func getPlaylist()
    func addPlaylist()
    func deletePlaylist()
    
    func getPlaylist(for index: Int)
    func getTracks()
    func getShuffledTracks()
    
    func getPlaylistURL()
    func getTrackUri(at index: Int)
    func getTrackURL(at index: Int)
    func getTrackArtistId(at index: Int)
    func getTrackAlbumId(at index: Int)
    func saveTrack(at index: Int)
    func deleteTrack(at index: Int)
}

protocol PlaylistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchPlaylist(_ playlist: Playlist, type: PlaylistType)
    func interactorFailedToFetchPlaylist()
    func interactorDidGetPlaylist(_ playlist: Playlist)
    func interactorFailedToGetPlaylist()
    func interactorDidDeletePlaylist()
    func interactorFailedToDeletePlaylist(_ error: String)
    func interactorDidAddPlaylist()
    func interactorFailedToAddPlaylist(_ error: String)
    
    func interactorDidGetPlaylist(tracks: [Track], for index: Int)
    
    func interactorDidGetTrackUri(_ uri: String)
    func interactorDidGetURL(_ url: String)
    func interactorDidGetTrackArtistId(_ artistId: String)
    func interactorDidGetTrackAlbumId(_ albumId: String)
    func interactorDidDeleteItemFromPlaylist(name: String?)
    func interactorFailedToDeleteItemFromPlaylist(_ error: String)
}
