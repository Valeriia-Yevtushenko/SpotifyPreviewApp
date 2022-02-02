//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

final class SearchViewPresenter {
    weak var view: SearchViewInputProtocol?
    var intractor: SearchInteractorInputProtocol?
}

extension SearchViewPresenter: SearchViewOutputProtocol {
    func viewDidUpdateBySearchText(_ text: String) {
        intractor?.fetchSearchText(text)
    }
}

extension SearchViewPresenter: SearchInteractorOutputProtocol {
    func interactorDidFetchData(_ data: ListOfTrack) {
        guard !data.tracks.items.isEmpty else {
            view?.setupData([])
            view?.displayLabel(with: "Unfortunately, there is no track with this name...")
            return
        }
        
        let viewModel: [TrackTableViewCellModel] = data.tracks.items.map {
            let artist = $0.artists.map { return $0.name }
            return TrackTableViewCellModel(image: $0.album.images[2].url, name: $0.name, artist: artist.joined(separator: ", "))
        }
        
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchData() {
        view?.displayLabel(with: "Oops, something went wrong...")
    }
}
