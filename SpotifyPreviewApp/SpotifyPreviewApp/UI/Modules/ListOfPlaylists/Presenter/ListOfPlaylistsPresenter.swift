//
//  PlaylistsPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation

class ListOfPlaylistsViewPresenter {
    weak var view: ListOfPlaylistsViewInputProtocol?
    var coordinator: ListOfPlaylistsModuleOutput?
    var interactor: ListOfPlaylistsInteractorInputProtocol?
}

extension ListOfPlaylistsViewPresenter: ListOfPlaylistsViewOutputProtocol {
    func viewDidTapCreatePlaylist(_ playlist: NewPlaylist) {
        interactor?.postNewPlaylist(playlist)
    }
    
    func viewSelectedItem(at index: Int) {
        
    }
    
    func viewDidLoad() {
        interactor?.getPlaylistsType()
        interactor?.fetchPlaylists()
    }
}

extension ListOfPlaylistsViewPresenter: ListOfPlaylistsInteractorOutputProtocol {
    func interactorDidPostNewPlaylist() {
        
    }
    
    func interactorDidFetchPlaylistsType(_ type: PlaylistType) {
        view?.setupPlaylistsType(type)
    }
    
    func interactorDidGetPlaylistId(_ data: String) {
        coordinator?.runPlaylistModule(data: data)
    }
    
    func interactorDidFetchPlaylists(_ data: Playlists) {
        guard let playlists = data.items, !playlists.isEmpty else {
            view?.displayLabel(with: "Unfortunately, this category is empty...")
            return
        }
        
        let viewModel: [CollectionViewCellModel]  = playlists.map({
            guard $0.images?.first?.url == nil else {
                return CollectionViewCellModel(image: $0.images?.first?.url)
            }
            
            return CollectionViewCellModel(name: $0.name)
        })
        
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchPlaylists() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to relod view")
    }
}
