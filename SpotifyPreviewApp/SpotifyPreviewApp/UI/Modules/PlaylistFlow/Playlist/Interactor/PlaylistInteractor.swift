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
    var urlBuilder: URLBuilderProtocol!
    weak var presenter: PlaylistInteractorOutputProtocol?
}

extension PlaylistInteractor: PlaylistInteractorInputProtocol {
    func getTrackArtistId(at index: Int) {
        guard let artistId = playlist?.tracks?.items?[index].track?.artists?.first?.identifier else {
            return
        }
        
        presenter?.interactorDidGetPlaylist(artistId)
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
