//
//  SavedTracksPresenter.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import Foundation

class SavedTracksPresenter {
    weak var view: SavedTracksViewInputProtocol?
    var interactor: SavedTracksInteractorInputProtocol?
    var coordinator: SavedTracksModuleOutput?
}

extension SavedTracksPresenter: SavedTracksViewOutputProtocol {
    func viewDidTapPlay() {
        interactor?.getPlaylist()
    }
    
    func viewDidTapShuffle() {
        interactor?.getShuffledPlaylist()
    }
    
    func viewDidLoad() {
        interactor?.getTracks()
    }
    
    func viewDidSelectItem(at index: Int) {
        interactor?.getPlaylist(for: index)
    }
    
    func viewDidTapAddItemToPlaylist(at index: Int) {
        interactor?.getTrackUri(at: index)
    }
    
    func viewDidTapShareItem(at index: Int) {
        interactor?.getTrackURL(at: index)
    }
    
    func viewDidTapShowItemArtist(at index: Int) {
        interactor?.getTrackArtistId(at: index)
    }
    
    func viewDidTapShowItemAlbum(at index: Int) {
        interactor?.getTrackAlbumId(at: index)
    }
}

extension SavedTracksPresenter: SavedTracksInteractorOutputProtocol {
    func interactorDidGetTracks(_ tracks: [TrackModel]) {
        guard !tracks.isEmpty else {
            view?.displayLabel(with: "You don't have saved tracks...")
            return
        }
        
        let tracks: [TrackTableViewCellModel] = tracks.map {
            return TrackTableViewCellModel(name: $0.name,
                                           artist: $0.artists,
                                           imageData: $0.image)
        }
        
        view?.setupData(tracks)
        view?.reloadData()
    }
    
    func interactorFailedToGetTracks() {
        view?.displayLabel(with: "You don't have saved tracks...")
    }
    
    func interactorDidGetPlaylist(tracks: [Track], for index: Int) {
        
    }
    
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
}
