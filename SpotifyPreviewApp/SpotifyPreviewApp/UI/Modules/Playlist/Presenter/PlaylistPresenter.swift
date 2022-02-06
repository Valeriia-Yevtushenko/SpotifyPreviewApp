//
//  PlaylistPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

final class PlaylistViewPresenter {
    weak var view: PlaylistViewInputProtocol?
    var coordinator: PlaylistModuleOutput?
    var interactor: PlaylistInteractorInputProtocol?
}

extension PlaylistViewPresenter: PlaylistViewOutputProtocol {
    func viewDidTapAddPlaylist() {
        interactor?.addPlaylist()
    }
    
    func viewDidTapDeletePlaylist() {
        interactor?.deletePlaylist()
    }
    
    func viewDidUpdate() {
        view?.updateHeaderView()
    }
    
    func viewWillDisappear() {
        coordinator?.finishedFlow()
    }
    
    func viewDidLoad() {
        interactor?.fetchPlaylist()
    }
}

extension PlaylistViewPresenter: PlaylistInteractorOutputProtocol {
    func interactorDidAddPlaylist() {
        view?.showConfirmationToastView()
    }
    
    func interactorFailedToAddPlaylist(_ error: String) {
        view?.displayErrorAlert(with: error)
    }
    
    func interactorDidDeletePlaylist() {
        coordinator?.backToPlaylists()
    }
    
    func interactorFailedToDeletePlaylist(_ error: String) {
        view?.displayErrorAlert(with: error)
    }
    
    func interactorDidFetchPlaylist(_ playlist: Playlist, type: PlaylistType) {
        let viewModel: [TrackTableViewCellModel]
        
        if let tracks = playlist.tracks.items, !tracks.isEmpty {
            viewModel = tracks.compactMap {
                let artists = $0.track?.artists?.compactMap { return $0.name }
                return TrackTableViewCellModel(image: ($0.track?.album?.images?[2].url),
                                               name: $0.track?.name, artist: artists?.joined(separator: ", "))
            }
        } else {
            viewModel = []
            view?.displayLabel(with: "Unfortunately, this playlist is empty...")
        }
 
        view?.setupPlaylistInfo(image: playlist.images?.first?.url, name: playlist.name, type: type)
        view?.setupPlaylistTracks(viewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchPlaylist() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to reload view")
    }
}
