//
//  ListOfArtistsIneractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

class ListOfArtistsIneractor {
    weak var presenter: ListOfArtistsInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
}

extension ListOfArtistsIneractor: ListOfArtistsInteractorInputProtocol {
    func fetchArtists() {
        
    }
    
    func getArtistId(at index: Int) {
        
    }
}
