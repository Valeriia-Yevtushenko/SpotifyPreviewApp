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
    func viewDidLoad() {
        
    }
    
    func viewSelectedItem(at index: Int) {
        
    }
}

extension ListOfArtistsPresenter: ListOfArtistsInteractorOutputProtocol {
    func interactorDidFetchArtists(_ data: Playlists) {
        
    }
    
    func interactorFailedToFetchArtists() {
        
    }
    
    func interactorDidGetPlaylistId(_ identifier: String) {
        
    }
}
