//
//  SavedTracksInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import Foundation

protocol SavedTracksInteractorInputProtocol: AnyObject {
    func getTracks()
    func getPlaylist(for index: Int)
    func getPlaylist()
    func getShuffledPlaylist()
    func getTrackUri(at index: Int)
    func getTrackURL(at index: Int)
    func getTrackArtistId(at index: Int)
    func getTrackAlbumId(at index: Int)
}

protocol SavedTracksInteractorOutputProtocol: AnyObject {
    func interactorDidGetTracks(_ tracks: [TrackModel])
    func interactorFailedToGetTracks()
    func interactorDidGetPlaylist(tracks: [Track], for index: Int)
    
    func interactorDidGetTrackUri(_ uri: String)
    func interactorDidGetTrackURL(_ url: String)
    func interactorDidGetTrackArtistId(_ artistId: String)
    func interactorDidGetTrackAlbumId(_ albumId: String)
}
