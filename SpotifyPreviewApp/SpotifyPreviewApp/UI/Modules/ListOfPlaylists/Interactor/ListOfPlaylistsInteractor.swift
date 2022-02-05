//
//  PlaylistsInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation
import PromiseKit

final class ListOfPlaylistsViewInteractor {
    private var playlists: Playlists?
    var presenter: ListOfPlaylistsInteractorOutputProtocol!
    var type: PlaylistType!
    var networkService: NetworkServiceProtocol!
}

extension ListOfPlaylistsViewInteractor: ListOfPlaylistsInteractorInputProtocol {
    func postNewPlaylist(_ playlist: NewPlaylist) {
        guard let data = try? JSONEncoder().encode(playlist) else {
            return
        }
        
        let promise: Promise<Playlists> = networkService.post(data: data, url: Request.userPlaylists.rawValue)
        
        firstly {
            promise
        }.done { data in
            self.playlists = data
            self.presenter.interactorDidFetchPlaylists(data)
        }.catch { _ in
            self.presenter.interactorFailedToFetchPlaylists()
        }
    }
    
    func getPlaylistsType() {
        presenter.interactorDidFetchPlaylistsType(type)
    }
    
    func getPlaylistId(at index: Int) {
        guard let playlistId = playlists?.items?[index].identifier else {
            return
        }
        
        presenter.interactorDidGetPlaylistId(playlistId)
    }
    
    func fetchPlaylists() {
        switch type {
        case .category(let categoryId):
            let promise: Promise<ListOfPlaylists> = networkService.fetch(Request.playlists.createUrl(data: categoryId))
            
            firstly {
                promise
            }.compactMap { data in
                return data.playlists
            }.done { data in
                self.playlists = data
                self.presenter.interactorDidFetchPlaylists(data)
            }.catch { _ in
                self.presenter.interactorFailedToFetchPlaylists()
            }
        case .user:
            let promise: Promise<Playlists> = networkService.fetch(Request.userPlaylists.rawValue)
            firstly {
                promise
            }.compactMap { data in
                return data
            }.done { data in
                self.playlists = data
                self.presenter.interactorDidFetchPlaylists(data)
            }.catch { _ in
                self.presenter.interactorFailedToFetchPlaylists()
            }
        case .none:
            self.presenter?.interactorFailedToFetchPlaylists()
        }
    }
}
