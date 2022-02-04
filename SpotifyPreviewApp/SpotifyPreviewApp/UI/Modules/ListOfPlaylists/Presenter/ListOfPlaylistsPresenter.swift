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
    func viewSelectedItem(at index: Int) {
        
    }
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
}

extension ListOfPlaylistsViewPresenter: ListOfPlaylistsInteractorOutputProtocol {
    func interactorDidGetData(_ data: String) {
        coordinator?.runPlaylistModule(data: data)
    }
    
    func interactorDidFetchData(_ data: Playlists) {
        guard let playlists = data.items, !playlists.isEmpty else {
            view?.displayLabel(with: "Unfortunately, this category is empty...")
            return
        }
        
        let viewModel: [CollectionViewCellModel]  = playlists.map({
            return CollectionViewCellModel(image: $0.images?[0].url, name: $0.name)
        })
        
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchData() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to relod view")
    }
}
