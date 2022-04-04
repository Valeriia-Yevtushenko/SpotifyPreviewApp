//
//  ArtistPresenter.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import Foundation

final class ArtistPresenter {
    weak var view: ArtistViewInputProtocol?
    var coordinator: ArtistModuleOutput?
    var interactor: ArtistInteractorInputProtocol?
}

extension ArtistPresenter: ArtistViewOutputProtocol {
    func viewDidTapShareArtist() {
        interactor?.getArtistURL()
    }
    
    func viewDidTapShowItemAlbum(at index: Int) {
        interactor?.getTrackAlbumId(for: index)
    }
    
    func viewDidTapAddItemToPlaylist(at index: Int) {
        interactor?.getTrackUri(for: index)
    }
    
    func viewDidTapShareItem(at index: Int) {
        interactor?.getTrackURL(for: index)
    }
    
    func viewDidTapDownloadItem(at index: Int) {
        
    }
    
    func viewDidTapOnTrack(at index: Int) {
        interactor?.getPlaylist(for: index)
    }
    
    func viewDidTapOnAlbum(at index: Int) {
        interactor?.getAlbumId(at: index)
    }
    
    func viewDidTapUnfollow() {
        interactor?.unfollowArtist()
    }
    
    func viewDidTapFollow() {
        interactor?.followOnArtist()
    }
    
    func viewDidRefresh() {
        interactor?.fetchArtistInfo()
    }
    
    func viewDidLoad() {
        interactor?.fetchArtistInfo()
    }
}

extension ArtistPresenter: ArtistInteractorOutputProtocol {
    func interactorDidGetTrackAlbumId(_ albumId: String) {
        coordinator?.runAlbumFlow(with: albumId)
    }
    
    func interactorDidGetTrackUri(_ uri: String) {
        coordinator?.runListOfPlaylistFlow(for: uri)
    }
    
    func interactorDidGetURL(_ url: String) {
        view?.shareURL(url)
    }
    
    func interactorDidGetPlaylist(tracks: [Track], for index: Int) {
        coordinator?.runPlayerFlow(with: tracks, for: index)
    }
    
    func interactorDidGetAlbumId(_ identifier: String) {
        coordinator?.runAlbumFlow(with: identifier)
    }
    
    func interactorUnfollowArtist() {
        view?.showConfirmationToastView()
        view?.setupArtistStatus(.unfollowed)
    }
    
    func interactorFailedToUnfollowArtist(_ error: String) {
        view?.displayErrorAlert(with: error)
    }
    
    func interactorDidFollowOnArtist() {
        view?.showConfirmationToastView()
        view?.setupArtistStatus(.followed)
    }
    
    func interactorFailedToFollowOnArtist(_ error: String) {
        view?.displayErrorAlert(with: error)
    }
    
    func interactorDidGetArtistStatus(_ status: ArtistStatus) {
        view?.setupArtistStatus(status)
    }
    
    func interactorDidFetchArtistInfo(_ artistInfo: (Artist?, [Track], [Album])) {
        let tracks: [TrackTableViewCellModel] = artistInfo.1.map {
            let artist = $0.artists?.compactMap { return $0.name }
            return TrackTableViewCellModel(image: $0.album?.images?[0].url, name: $0.name, artist: artist?.joined(separator: ", "))
        }
        
        let albums: [TableViewCellModel] = artistInfo.2.map {
            return TableViewCellModel(name: $0.name, image: $0.images?.first?.url)
        }
        
        view?.setupArtistInfo(ArtistInfoViewModel(image: artistInfo.0?.images?[1].url,
                                                  name: artistInfo.0?.name,
                                                  tracks: tracks,
                                                  albums: albums))
        view?.reloadData()
    }
    
    func interactorFailedToFetchArtistInfo() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to reload view")
    }
}
