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
    var urlBuilder: URLBuilderProtocol!
}

extension ListOfArtistsIneractor: ListOfArtistsInteractorInputProtocol {
    func fetchArtists() {
        let url = urlBuilder
                .with(path: .following)
                .with(queryItems: ["type": "artist"])
                .build()
        
        let promise: Promise<ListOfArtists> = networkService.fetch(url)
        
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
