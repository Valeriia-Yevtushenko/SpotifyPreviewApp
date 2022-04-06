//
//  AlbumInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation
import PromiseKit

class AlbumInteractor {
    private var album: Album?
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    var databaseManager: RealmDatabaseService!
    var identifier: String!
    weak var presenter: AlbumInteractorOutputProtocol?
}

extension AlbumInteractor: AlbumInteractorInputProtocol {
    func saveTrack(at index: Int) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let track = self.album?.tracks?.items[index] else {
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
    
    func getAlbumURL() {
        guard let url = album?.externalUrls.spotify else {
            return
        }
        
        presenter?.interactorDidGetURL(url)
    }
    
    func getTrackUri(at index: Int) {
        guard let uri = album?.tracks?.items[index].uri else {
            return
        }
        
        presenter?.interactorDidGetTrackUri(uri)
    }
    
    func getTrackURL(at index: Int) {
        guard let url = album?.tracks?.items[index].externalUrls.spotify else {
            return
        }
        
        presenter?.interactorDidGetURL(url)
    }
    
    func getPlaylist() {
        let tracks: [Track] = album?.tracks?.items.compactMap {
            return Track(identifier: $0.identifier,
                         album: self.album,
                         artists: $0.artists,
                         name: $0.name,
                         uri: $0.uri,
                         externalUrls: $0.externalUrls,
                         previewUrl: $0.previewUrl)
        } ?? []
        
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: 0)
    }
    
    func getShuffledPlaylist() {
        var tracks: [Track] = album?.tracks?.items.compactMap {
            return Track(identifier: $0.identifier,
                         album: self.album,
                         artists: $0.artists,
                         name: $0.name,
                         uri: $0.uri,
                         externalUrls: $0.externalUrls,
                         previewUrl: $0.previewUrl)
        } ?? []
        
        tracks.shuffle()
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: 0)
    }
    
    func getPlaylist(for index: Int) {
        let tracks: [Track] = album?.tracks?.items.compactMap {
            return Track(identifier: $0.identifier,
                         album: self.album,
                         artists: $0.artists,
                         name: $0.name,
                         uri: $0.uri,
                         externalUrls: $0.externalUrls,
                         previewUrl: $0.previewUrl)
        } ?? []
        
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: index)
    }
    
    func fetchAlbum() {
        let promise: Promise<Album> = networkService.fetch(urlBuilder
                                                                .with(path: .album)
                                                                .with(pathParameter: identifier)
                                                                .build())
        
        promise.done { album in
            self.album = album
            self.presenter?.interactorDidFetchAlbum(album)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchAlbum()
        }
    }
}
