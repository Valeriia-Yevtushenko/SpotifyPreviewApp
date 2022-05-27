//
//  PlaylistsInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation
import PromiseKit

final class ListOfPlaylistsInteractor {
    private var playlists: Playlists?
    weak var presenter: ListOfPlaylistsInteractorOutputProtocol?    
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    var type: PlaylistType!
    var newItemForPlaylist: String?
}

extension ListOfPlaylistsInteractor: ListOfPlaylistsInteractorInputProtocol {
    func postNewPlaylist(_ playlist: NewPlaylist) {
        guard let data = try? JSONEncoder().encode(playlist) else {
            return
        }
        
        let promise: Promise<Playlists> = networkService.post(data: data,
                                                              url: urlBuilder
                                                                .with(path: .userPlaylist)
                                                                .build())
        
        promise.done { data in
            self.playlists = data
            self.presenter?.interactorDidPostNewPlaylist()
        }.catch { error in
            self.presenter?.interactorFailedToPostPlaylist(error.localizedDescription)
        }
    }
    
    func getPlaylistId(at index: Int) {
        guard let playlistId = playlists?.items?[index].identifier else {
            return
        }
        
        if let newItemForPlaylist = newItemForPlaylist {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: ["uris": [newItemForPlaylist]]) else {
                return
            }
            
            let promise: Promise<Void> = networkService.post(data: jsonData, url: urlBuilder
                                                                .with(path: .playlistTracks)
                                                                .with(pathParameter: playlistId)
                                                                .with(queryItems: ["uris": newItemForPlaylist])
                                                                .build())
            
            promise.done { _ in
                self.presenter?.interactorDidAddNewItemToPlaylist(name: self.playlists?.items?[index].name)
            }.catch { error in
                self.presenter?.interactorFailedToAddNewItemToPlaylist(error.localizedDescription)
            }
            
        } else {
            presenter?.interactorDidGetPlaylistId(playlistId, type: type)
        }
    }
    
    func fetchPlaylists() {
        switch type {
        case .category(let categoryId):
            let promise: Promise<ListOfPlaylists> = networkService.fetch(urlBuilder
                                                                            .with(path: .category)
                                                                            .with(pathParameter: categoryId)
                                                                            .build())
            
            promise.compactMap { data in
                return data.playlists
            }.done { data in
                self.playlists = data
                self.presenter?.interactorDidFetchPlaylists(data, type: self.type)
            }.catch { _ in
                self.presenter?.interactorFailedToFetchPlaylists()
            }
        case .user:
            let promise: Promise<Playlists> = networkService.fetch(urlBuilder
                                                                    .with(path: .userPlaylist)
                                                                    .build())
            promise.done { data in
                self.playlists = data
                self.presenter?.interactorDidFetchPlaylists(data, type: self.type)
            }.catch { _ in
                self.presenter?.interactorFailedToFetchPlaylists()
            }
        case .none:
            self.presenter?.interactorFailedToFetchPlaylists()
        }
    }
}
