//
//  ListOfArtistsIneractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation
import PromiseKit

class ListOfArtistsIneractor {
    private var artists: [Artist]?
    weak var presenter: ListOfArtistsInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
}

extension ListOfArtistsIneractor: ListOfArtistsInteractorInputProtocol {
    func fetchArtists() {
        let promise: Promise<ListOfArtists> = networkService.fetch(Request.userFollows.rawValue)
        
        promise.done { listOfArtists in
            self.artists = listOfArtists.artists.items
            self.presenter?.interactorDidFetchArtists(listOfArtists)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchArtists()
        }
    }
    
    func getArtistId(at index: Int) {
        guard let identifier = artists?[index].identifier else {
            return
        }
        
        presenter?.interactorDidGetPlaylistId(identifier)
    }
}
