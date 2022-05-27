//
//  PlaylistsPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation

class ListOfPlaylistsPresenter {
    weak var view: ListOfPlaylistsViewInputProtocol?
    var coordinator: ListOfPlaylistsModuleOutput?
    var interactor: ListOfPlaylistsInteractorInputProtocol?
}

extension ListOfPlaylistsPresenter: ListOfPlaylistsViewOutputProtocol {
    func viewDismiss() {
        coordinator?.dismiss()
    }
    
    func viewDidRefresh() {
        interactor?.fetchPlaylists()
    }
    
    func viewWillAppear() {
        interactor?.fetchPlaylists()
    }
    
    func viewDidTapCreatePlaylist(_ playlist: NewPlaylist) {
        interactor?.postNewPlaylist(playlist)
    }
    
    func viewSelectedItem(at index: Int) {
        interactor?.getPlaylistId(at: index)
    }
    
    func viewDidLoad() {
        interactor?.fetchPlaylists()
    }
}

extension ListOfPlaylistsPresenter: ListOfPlaylistsInteractorOutputProtocol {
    func interactorDidAddNewItemToPlaylist(name: String?) {
        view?.showToastView(with: name ?? "playlist")
    }
    
    func interactorFailedToAddNewItemToPlaylist(_ error: String) {
        view?.displayErrorAlert(title: "Failed to add track", text: error)
    }
    
    func interactorDidFetchPlaylists(_ data: Playlists, type: PlaylistType) {
        let viewModel: [CollectionViewCellModel]
        
        if let playlists = data.items, !playlists.isEmpty {
            viewModel = playlists.map({
                guard $0.images?.first?.url == nil else {
                    return CollectionViewCellModel(image: $0.images?.first?.url)
                }
                
                return CollectionViewCellModel(name: $0.name)
            })
        } else {
            viewModel = []
            view?.displayLabel(with: "Unfortunately, this category is empty...")
        }
        
        view?.setupData(viewModel, type: type)
        view?.reloadData()
    }
    
    func interactorFailedToPostPlaylist(_ error: String) {
        view?.displayErrorAlert(title: "Failed to create new playlist", text: error)
    }
    
    func interactorDidPostNewPlaylist() {
        interactor?.fetchPlaylists()
    }
    
    func interactorDidGetPlaylistId(_ identifier: String, type: PlaylistType) {
        coordinator?.runPlaylistModule(with: identifier, type: type)
    }
    
    func interactorFailedToFetchPlaylists() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to reload view")
    }
}
