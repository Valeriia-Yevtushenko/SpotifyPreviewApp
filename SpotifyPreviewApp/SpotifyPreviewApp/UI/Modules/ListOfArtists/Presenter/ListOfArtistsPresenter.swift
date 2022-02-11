//
//  ListOfArtistsPresenter.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

class ListOfArtistsPresenter {
    weak var view: ListOfArtistsViewInputProtocol?
    var coordinator: ListOfArtistsModuleOutput?
    var interactor: ListOfArtistsInteractorInputProtocol?
}

extension ListOfArtistsPresenter: ListOfArtistsViewOutputProtocol {
    func viewWillAppear() {
        interactor?.fetchArtists()
    }
    
    func viewDidRefresh() {
        interactor?.fetchArtists()
    }
    
    func viewDidLoad() {
        interactor?.fetchArtists()
    }
    
    func viewSelectedItem(at index: Int) {
        interactor?.getArtistId(at: index)
    }
}

extension ListOfArtistsPresenter: ListOfArtistsInteractorOutputProtocol {
    func interactorDidFetchArtists(_ data: ListOfArtists) {
        let viewModel: [TableViewCellModel]
        
        if !data.artists.items.isEmpty {
            viewModel = data.artists.items.map({
                return TableViewCellModel(name: $0.name, image: $0.images?[0].url)
            })
        } else {
            viewModel = []
            view?.displayLabel(with: "Unfortunately, you don't have favorite artists...")
        }
        
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchArtists() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to reload view")
    }
    
    func interactorDidGetPlaylistId(_ identifier: String) {
        coordinator?.runArtistFlow(with: identifier)
    }
}
