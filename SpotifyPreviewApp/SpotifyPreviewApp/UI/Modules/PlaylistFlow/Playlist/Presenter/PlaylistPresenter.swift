//
//  PlaylistPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

final class PlaylistPresenter {
    weak var view: PlaylistViewInputProtocol?
    var coordinator: PlaylistModuleOutput?
    var interactor: PlaylistInteractorInputProtocol?
}

extension PlaylistPresenter: PlaylistViewOutputProtocol {
    func viewDidTapPlay() {
        interactor?.getTracks()
    }
    
    func viewDidTapShuffle() {
        interactor?.getShuffledTracks()
    }
    
    func viewDidSelectItem(at index: Int) {
        interactor?.getPlaylist(for: index)
    }
    
    func viewWillAppear() {
        interactor?.fetchPlaylist()
    }
    
    func viewDidRefresh() {
        interactor?.fetchPlaylist()
    }
    
    func viewDidEditPlaylist() {
        interactor?.getPlaylist()
    }
    
    func viewDidTapAddPlaylist() {
        interactor?.addPlaylist()
    }
    
    func viewDidTapDeletePlaylist() {
        interactor?.deletePlaylist()
    }
    
    func viewDidLoad() {
        interactor?.fetchPlaylist()
    }
}

extension PlaylistPresenter: PlaylistInteractorOutputProtocol {
    func interactorDidGetPlaylist(tracks: [Track], for index: Int) {
        coordinator?.runPlayerFlow(with: tracks, for: index)
    }
    
    func interactorDidGetPlaylist(_ playlist: Playlist) {
        coordinator?.runEditPlaylistModule(with: playlist)
    }
    
    func interactorFailedToGetPlaylist() {
        view?.displayErrorAlert(with: "Playlist editing isn't available at the moment.")
    }
    
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
        let tracksViewModel: [TrackTableViewCellModel]
        
        if let tracks = playlist.tracks?.items, !tracks.isEmpty {
            tracksViewModel = tracks.compactMap {
                let artists = $0.track?.artists?.compactMap { return $0.name }
                return TrackTableViewCellModel(image: ($0.track?.album?.images?[2].url),
                                               name: $0.track?.name, artist: artists?.joined(separator: ", "))
            }
        } else {
            tracksViewModel = []
            view?.displayLabel(with: "Unfortunately, this playlist is empty...")
        }
        
        view?.setupPlaylist(model: PlaylistViewControllerModel(name: playlist.name,
                                                               type: type,
                                                               imageUrl: playlist.images?.first?.url), tracks: tracksViewModel)
        view?.reloadData()
    }
    
    func interactorFailedToFetchPlaylist() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to reload view")
    }
}
