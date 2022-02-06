//
//  PlaylistInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation
import PromiseKit

final class PlaylistViewInteractor {
    var presenter: PlaylistInteractorOutputProtocol?
    var playlistId: String!
    var playlistType: PlaylistType!
    var networkService: NetworkServiceProtocol!
}

extension PlaylistViewInteractor: PlaylistInteractorInputProtocol {
    func deletePlaylist() {
        guard let playlistId = playlistId else {
            return
        }
        
        networkService.delete(url: Request.deletePlaylist.createUrl(data: playlistId)).done { _ in
            self.presenter?.interactorDidDeletePlaylist()
        }.catch { error in
            self.presenter?.interactorFailedToDeletePlaylist(error.localizedDescription)
        }
    }
    
    func fetchPlaylist() {
        let promise: Promise<Playlist> = networkService.fetch(Request.playlist.createUrl(data: playlistId))
        promise.done { data in
            self.presenter?.interactorDidFetchPlaylist(data, type: self.playlistType)
        }.catch {_ in
            self.presenter?.interactorFailedToFetchPlaylist()
        }
    }
}
