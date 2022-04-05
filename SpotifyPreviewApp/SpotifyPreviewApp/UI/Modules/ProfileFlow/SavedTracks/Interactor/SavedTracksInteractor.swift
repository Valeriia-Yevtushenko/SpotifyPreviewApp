//
//  SavedTracksInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import Foundation

class SavedTracksInteractor {
    private var tracks: [TrackModel]?
    var databaseManager: RealmDatabaseService!
    weak var presenter: SavedTracksInteractorOutputProtocol?
}

extension SavedTracksInteractor: SavedTracksInteractorInputProtocol {
    func getTracks() {
        guard let tracks: [TrackModel] = databaseManager.fetch() else {
            presenter?.interactorFailedToGetTracks()
            return
        }
        
        self.tracks = tracks
        presenter?.interactorDidGetTracks(tracks)
    }
    
    func getPlaylist(for index: Int) {
        
    }
    
    func getPlaylist() {
        
    }
    
    func getShuffledPlaylist() {
        
    }
    
    func getTrackUri(at index: Int) {
        
    }
    
    func getTrackURL(at index: Int) {
        
    }
    
    func getTrackArtistId(at index: Int) {
        
    }
    
    func getTrackAlbumId(at index: Int) {
        
    }
}
