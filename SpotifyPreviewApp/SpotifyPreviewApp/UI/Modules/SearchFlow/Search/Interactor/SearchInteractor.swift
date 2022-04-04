//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation
import PromiseKit

final class SearchInteractor {
    private var listOfSearchedTracks: ListOfSearchedTracks?
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    weak var presenter: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorInputProtocol {
    func getTrackUri(at index: Int) {
        guard let uri = listOfSearchedTracks?.tracks.items[index].uri else {
            return
        }
        
        presenter?.interactorDidGetTrackUri(uri)
    }
    
    func getTrackURL(at index: Int) {
        guard let url = listOfSearchedTracks?.tracks.items[index].externalUrls.spotify else {
            return
        }
        
        presenter?.interactorDidGetTrackURL(url)
    }
    
    func getTrackArtistId(at index: Int) {
        guard let artistId = listOfSearchedTracks?.tracks.items[index].artists?.first?.identifier else {
            return
        }
        
        presenter?.interactorDidGetTrackArtistId(artistId)
    }
    
    func getTrackAlbumId(at index: Int) {
        guard let albumId = listOfSearchedTracks?.tracks.items[index].album?.identifier else {
            return
        }
        
        presenter?.interactorDidGetTrackAlbumId(albumId)
    }
    
    func getTrack(at index: Int) {
        guard let track = listOfSearchedTracks?.tracks.items[index] else {
            return
        }
        
        presenter?.interactorDidGetTrack(tracks: track)
    }
    
    func fetchSearchText(_ text: String) {
        guard let track = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let promise: Promise<ListOfSearchedTracks> = networkService.fetch(urlBuilder
                                                                            .with(path: .search)
                                                                            .with(queryItems: ["q": track,
                                                                                               "type": "track",
                                                                                               "limit": "50"])
                                                                            .build())
        
        promise.done { data in
            self.listOfSearchedTracks = data
            self.presenter?.interactorDidFetchData(data)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchData()
        }
    }
}
