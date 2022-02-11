//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

final class SearchPresenter {
    weak var view: SearchViewInputProtocol?
    var intractor: SearchInteractorInputProtocol?
}

extension SearchPresenter: SearchViewOutputProtocol {
    func viewDidUpdateBySearchText(_ text: String) {
        intractor?.fetchSearchText(text)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func interactorDidFetchData(_ data: ListOfSearchedTracks) {
        guard !data.tracks.items.isEmpty else {
            view?.setupData([])
            view?.displayLabel(with: "Unfortunately, there is no track with this name...")
            return
        }
        
        let viewModel: [TrackTableViewCellModel] = data.tracks.items.map {
            let artists = $0.artists?.compactMap { $0.name }
            return TrackTableViewCellModel(image: $0.album?.images?[2].url, name: $0.name, artist: artists?.joined(separator: ", "))
        }
        
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchData() {
        view?.displayLabel(with: "Oops, something went wrong...")
    }
}
