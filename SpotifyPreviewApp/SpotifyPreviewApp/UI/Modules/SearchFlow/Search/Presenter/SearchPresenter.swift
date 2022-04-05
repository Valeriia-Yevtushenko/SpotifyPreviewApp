//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import UIKit

final class SearchPresenter {
    weak var view: SearchViewInputProtocol?
    var interactor: SearchInteractorInputProtocol?
    var coordinator: SearchModuleOutput?
}

extension SearchPresenter: SearchViewOutputProtocol {
    func viewDidTapAddItemToPlaylist(at index: Int) {
        interactor?.getTrackUri(at: index)
    }
    
    func viewDidTapShareItem(at index: Int) {
        interactor?.getTrackURL(at: index)
    }
    
    func viewDidTapDownloadItem(at index: Int) {
        interactor?.saveTrack(at: index)
    }
    
    func viewDidTapShowItemArtist(at index: Int) {
        interactor?.getTrackArtistId(at: index)
    }
    
    func viewDidTapShowItemAlbum(at index: Int) {
        interactor?.getTrackAlbumId(at: index)
    }
    
    func viewDidSelectItem(at index: Int) {
        interactor?.getTrack(at: index)
    }
    
    func viewDidUpdateBySearchText(_ text: String) {
        interactor?.fetchSearchText(text)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func interactorDidGetTrackUri(_ uri: String) {
        coordinator?.runListOfPlaylistFlow(for: uri)
    }
    
    func interactorDidGetTrackURL(_ url: String) {
        view?.shareURL(url)
    }
    
    func interactorDidGetTrackArtistId(_ artistId: String) {
        coordinator?.runArtistModule(with: artistId)
    }
    
    func interactorDidGetTrackAlbumId(_ albumId: String) {
        coordinator?.runAlbumModule(with: albumId)
    }
    
    func interactorDidGetTrack(tracks: [Track]) {
        let tracks: [PlayerItem] = tracks.compactMap {
            let artist = $0.artists?.compactMap { return $0.name }
            return PlayerItem(duration: nil,
                              url: $0.previewUrl,
                              image: $0.album?.images?.first?.url,
                              title: $0.name,
                              artists: artist?.joined(separator: ", "), data: nil)
        }
        coordinator?.runPlayerFlow(with: tracks, for: 0)
    }
    
    func interactorDidFetchData(_ data: ListOfSearchedTracks) {
        guard !data.tracks.items.isEmpty else {
            view?.setupData([])
            view?.displayLabel(with: "Unfortunately, there is no track with this name...")
            return
        }
        
        let viewModel: [TrackTableViewCellModel] = data.tracks.items.map {
            let artists = $0.artists?.compactMap { $0.name }
            return TrackTableViewCellModel(name: $0.name,
                                           artist: artists?.joined(separator: ", "),
                                           image: $0.album?.images?[0].url)
        }
        
        view?.setupData(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchData() {
        view?.displayLabel(with: "Oops, something went wrong...")
    }
}
