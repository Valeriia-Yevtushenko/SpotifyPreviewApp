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
    func getData(at index: Int) {
        guard let playlistId = playlists?.items?[index].identifier else {
            return
        }
        
        presenter.interactorDidGetData(playlistId)
    }
    
    func fetchData() {
        switch type {
        case .category(let categoryId):
            let promise: Promise<ListOfPlaylists> = networkService.fetch(Request.playlists.createUrl(data: categoryId))
            
            firstly {
                promise
            }.compactMap { data in
                return data.playlists
            }.done { data in
                self.playlists = data
                self.presenter.interactorDidFetchData(data)
            }.catch { _ in
                self.presenter.interactorFailedToFetchData()
            }
        case .user:
            let promise: Promise<Playlists> = networkService.fetch(Request.userPlaylists.rawValue)
            firstly {
                promise
            }.compactMap { data in
                return data
            }.done { data in
                self.playlists = data
                self.presenter.interactorDidFetchData(data)
            }.catch { _ in
                self.presenter.interactorFailedToFetchData()
            }
        case .none:
            self.presenter?.interactorFailedToFetchData()
        }
    }
}
