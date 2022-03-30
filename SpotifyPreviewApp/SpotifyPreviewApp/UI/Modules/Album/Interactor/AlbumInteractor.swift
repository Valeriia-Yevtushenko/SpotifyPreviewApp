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
    var identifier: String!
    weak var presenter: AlbumInteractorOutputProtocol?
}

extension AlbumInteractor: AlbumInteractorInputProtocol {
    func getPlaylist() {
        let tracks: [Track] = album?.tracks?.items.compactMap {
            return $0
        } ?? []
        
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: 0)
    }
    
    func getShuffledPlaylist() {
        var tracks: [Track] = album?.tracks?.items.compactMap {
            return $0
        } ?? []
        
        tracks.shuffle()
        presenter?.interactorDidGetPlaylist(tracks: tracks, for: 0)
    }
    
    func getPlaylist(for index: Int) {
        let tracks: [Track] = album?.tracks?.items.compactMap {
            return $0
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
