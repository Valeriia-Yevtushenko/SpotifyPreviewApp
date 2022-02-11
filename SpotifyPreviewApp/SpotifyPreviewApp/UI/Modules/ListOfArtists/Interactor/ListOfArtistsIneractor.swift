//
//  ListOfArtistsIneractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation
import PromiseKit

class ListOfArtistsIneractor {
    weak var presenter: ListOfArtistsInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
}

extension ListOfArtistsIneractor: ListOfArtistsInteractorInputProtocol {
    func fetchArtists() {
        let promise: Promise<ListOfArtists> = networkService.fetch(Request.userFollows.rawValue)
        
        promise.done { listOfArtists in
            self.presenter?.interactorDidFetchArtists(listOfArtists)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchArtists()
        }
    }
    
    func getArtistId(at index: Int) {
        
    }
}
