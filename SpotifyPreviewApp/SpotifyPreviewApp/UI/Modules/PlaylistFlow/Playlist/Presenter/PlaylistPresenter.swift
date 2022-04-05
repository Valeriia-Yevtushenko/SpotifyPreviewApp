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
    func viewDidTapSharePlaylist() {
        interactor?.getPlaylistURL()
    }
    
    func viewDidTapPlay() {
        interactor?.getTracks()
    }
    
    func viewDidTapShuffle() {
        interactor?.getShuffledTracks()
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
    
    func viewDidTapDeleteItem(at index: Int) {
        interactor?.deleteTrack(at: index)
    }
    
    func viewDidTapDownloadItem(at index: Int) {
        
    }
    
    func viewDidTapShowItemArtist(at index: Int) {
        interactor?.getTrackArtistId(at: index)
    }
    
    func viewDidTapShowItemAlbum(at index: Int) {
        interactor?.getTrackAlbumId(at: index)
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
    func interactorDidDeleteItemFromPlaylist(name: String?) {
        view?.showConfirmationToastView(with: "Successfully deleted")
        interactor?.fetchPlaylist()
    }
    
    func interactorFailedToDeleteItemFromPlaylist(_ error: String) {
        view?.displayErrorAlert(with: error)
    }
    
    func interactorDidGetTrackArtistId(_ artistId: String) {
        coordinator?.runArtistModule(with: artistId)
    }
    
    func interactorDidGetTrackAlbumId(_ albumId: String) {
        coordinator?.runAlbumModule(with: albumId)
    }
    
    func interactorDidGetURL(_ url: String) {
        view?.shareURL(url)
    }
    
    func interactorDidGetTrackUri(_ uri: String) {
        coordinator?.showListOfPlaylists(for: uri)
    }
    
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
        view?.showConfirmationToastView(with: "Successfully added")
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
                return TrackTableViewCellModel(name: $0.track?.name,
                                               artist: artists?.joined(separator: ", "),
                                               image: ($0.track?.album?.images?[2].url))
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
