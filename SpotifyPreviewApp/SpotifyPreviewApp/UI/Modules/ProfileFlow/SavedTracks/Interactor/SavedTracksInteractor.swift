//
//  SavedTracksInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import Foundation
import CoreMedia

class SavedTracksInteractor {
    private var tracks: [TrackModel]!
    var databaseManager: RealmDatabaseService!
    weak var presenter: SavedTracksInteractorOutputProtocol?
}

extension SavedTracksInteractor: SavedTracksInteractorInputProtocol {
    func getTracks() {
        guard let tracks: [TrackModel] = databaseManager.fetch() else {
            tracks = []
            presenter?.interactorFailedToGetTracks()
            return
        }
        
        self.tracks = tracks
        presenter?.interactorDidGetTracks(tracks)
    }
    
    func getPlaylist(for index: Int) {
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: index)
    }
    
    func getPlaylist() {
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: 0)
    }
    
    func getShuffledPlaylist() {
        presenter?.interactorDidGetPlaylist(tracks: tracks.shuffled(), for: 0)
    }
    
    func getTrackUri(at index: Int) {
        presenter?.interactorDidGetTrackUri(tracks[index].uri)
    }
    
    func getTrackURL(at index: Int) {
        presenter?.interactorDidGetTrackUri(tracks[index].extetnalUrl)
    }
    
    func getTrackArtistId(at index: Int) {
        presenter?.interactorDidGetTrackUri(tracks[index].artistId)
    }
    
    func getTrackAlbumId(at index: Int) {
        presenter?.interactorDidGetTrackUri(tracks[index].albumId)
    }
}
