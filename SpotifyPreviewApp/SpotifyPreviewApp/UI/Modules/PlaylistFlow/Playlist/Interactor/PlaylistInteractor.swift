//
//  PlaylistInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation
import PromiseKit

final class PlaylistInteractor {
    private var playlist: Playlist?
    var playlistId: String!
    var playlistType: PlaylistType!
    var networkService: NetworkServiceProtocol!
    var databaseManager: RealmDatabaseService!
    var urlBuilder: URLBuilderProtocol!
    weak var presenter: PlaylistInteractorOutputProtocol?
}

extension PlaylistInteractor: PlaylistInteractorInputProtocol {
    func saveTrack(at index: Int) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let track = self.playlist?.tracks?.items?[index].track else {
                return
            }
            
            let trackModel = TrackModel()
            trackModel.uri = track.uri
            trackModel.name = track.name
            trackModel.identifier = track.identifier
            trackModel.extetnalUrl = track.externalUrls.spotify
            trackModel.albumId = track.album?.identifier ?? ""
            trackModel.artistId = track.artists?.first?.identifier ?? ""
            trackModel.artists = track.artists?.compactMap { $0.name }.joined(separator: ", ") ?? ""
            
            if let image = URL(string: track.album?.images?.first?.url ?? "") {
                trackModel.image = try? Data(contentsOf: image)
            }
            
            if let data = URL(string: track.previewUrl ?? "") {
                trackModel.data = try? Data(contentsOf: data)
            }
            
            DispatchQueue.main.async {
                self.databaseManager.save(trackModel)
            }
        }
    }
    
    func getPlaylistURL() {
        guard let url = playlist?.externalUrls.spotify else {
            return
        }
        
        presenter?.interactorDidGetURL(url)
    }
    
    func deleteTrack(at index: Int) {
        guard let trackUri = playlist?.tracks?.items?[index].track?.uri,
              let jsonData = try? JSONSerialization.data(withJSONObject: ["tracks": [["uri": trackUri]]]) else {
            return
        }
        
        let promise: Promise<Void> = networkService.delete(data: jsonData, url: urlBuilder
                                                            .with(path: .playlistTracks)
                                                            .with(pathParameter: playlistId)
                                                            .build())
        
        promise.done { _ in
            self.presenter?.interactorDidDeleteItemFromPlaylist(name: self.playlist?.name)
        }.catch { error in
            self.presenter?.interactorFailedToDeleteItemFromPlaylist(error.localizedDescription)
        }
    }
    
    func getTrackArtistId(at index: Int) {
        guard let artistId = playlist?.tracks?.items?[index].track?.artists?.first?.identifier else {
            return
        }
        
        presenter?.interactorDidGetTrackArtistId(artistId)
    }
    
    func getTrackAlbumId(at index: Int) {
        guard let albumId = playlist?.tracks?.items?[index].track?.album?.identifier else {
            return
        }
        
        presenter?.interactorDidGetTrackAlbumId(albumId)
    }
    
    func getTrackURL(at index: Int) {
        guard let url = playlist?.tracks?.items?[index].track?.externalUrls.spotify else {
            return
        }
        
        presenter?.interactorDidGetURL(url)
    }
    
    func getTrackUri(at index: Int) {
        guard let uri = playlist?.tracks?.items?[index].track?.uri else {
            return
        }
        
        presenter?.interactorDidGetTrackUri(uri)
    }
    
    func getTracks() {
        let tracks: [Track] = playlist?.tracks?.items?.compactMap({
            return $0.track
        }) ?? []
        
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: 0)
    }
    
    func getShuffledTracks() {
        var tracks: [Track] = playlist?.tracks?.items?.compactMap({
            return $0.track
        }) ?? []
        
        tracks.shuffle()
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: 0)
    }
    
    func getPlaylist(for index: Int) {
        let tracks: [Track] = playlist?.tracks?.items?.compactMap({
            return $0.track
        }) ?? []
        
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: index)
    }
    
    func getPlaylist() {
        guard let playlist = playlist else {
            presenter?.interactorFailedToGetPlaylist()
            return
        }
        
        presenter?.interactorDidGetPlaylist(playlist)
    }
    
    func addPlaylist() {
        guard let playlistId = playlistId, let jsonData = try? JSONSerialization.data(withJSONObject: ["public": false]) else {
            return
        }
        
        networkService.put(data: jsonData,
                           url: urlBuilder
                            .with(path: .playlistFollowers)
                            .with(pathParameter: playlistId)
                            .build())
            .done { _ in
                self.presenter?.interactorDidAddPlaylist()
            }.catch { error in
                self.presenter?.interactorFailedToAddPlaylist(error.localizedDescription)
            }
    }
    
    func deletePlaylist() {
        guard let playlistId = playlistId else {
            return
        }
        
        networkService.delete(url: urlBuilder
                                .with(path: .playlistFollowers)
                                .with(pathParameter: playlistId)
                                .build())
            .done { _ in
                self.presenter?.interactorDidDeletePlaylist()
            }.catch { error in
                self.presenter?.interactorFailedToDeletePlaylist(error.localizedDescription)
            }
    }
    
    func fetchPlaylist() {
        let promise: Promise<Playlist> = networkService.fetch(urlBuilder
                                                                .with(path: .playlist)
                                                                .with(pathParameter: playlistId)
                                                                .build())
        promise.done { data in
            self.playlist = data
            self.presenter?.interactorDidFetchPlaylist(data, type: self.playlistType)
        }.catch {_ in
            self.presenter?.interactorFailedToFetchPlaylist()
        }
    }
}
