//
//  AlbumPresenter.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

class AlbumPresenter {
    weak var view: AlbumViewInputProtocol?
    var coordinator: AlbumModuleOutput?
    var interactor: AlbumInteractorInputProtocol?
}

extension AlbumPresenter: AlbumViewOutputProtocol {
    func viewDidTapShareAlbum() {
        interactor?.getAlbumURL()
    }
    
    func viewDidTapShareItem(at index: Int) {
        interactor?.getTrackURL(at: index)
    }
    
    func viewDidTapAddItemToPlaylist(at index: Int) {
        interactor?.getTrackUri(at: index)
    }
    
    func viewDidTapDownloadItem(at index: Int) {
        interactor?.saveTrack(at: index)
    }
    
    func viewDidTapPlay() {
        interactor?.getPlaylist()
    }
    
    func viewDidTapShuffle() {
        interactor?.getShuffledPlaylist()
    }
    
    func viewWillDisappear() {
        coordinator?.finishFlow()
    }
    
    func viewDidRefresh() {
        interactor?.fetchAlbum()
    }
    
    func viewDidLoad() {
        interactor?.fetchAlbum()
    }
    
    func viewSelectedItem(at index: Int) {
        interactor?.getPlaylist(for: index)
    }
}

extension AlbumPresenter: AlbumInteractorOutputProtocol {
    func interactorDidGetTrackUri(_ uri: String) {
        coordinator?.runListOfPlaylistFlow(for: uri)
    }
    
    func interactorDidGetURL(_ url: String) {
        view?.shareURL(url)
    }
    
    func interactorDidGetPlaylist(tracks: [Track], for index: Int) {
        let tracks: [PlayerItem] = tracks.compactMap {
            let artist = $0.artists?.compactMap { return $0.name }
            return PlayerItem(duration: nil,
                              url: $0.previewUrl,
                              image: $0.album?.images?.first?.url,
                              title: $0.name,
                              artists: artist?.joined(separator: ", "), data: nil)
        }
        
        coordinator?.runPlayerFlow(with: tracks, for: index)
    }
    
    func interactorDidFetchAlbum(_ data: Album) {
        let tracksViewModel: [TrackTableViewCellModel]
        
        if let tracks = data.tracks?.items, !tracks.isEmpty {
            tracksViewModel = tracks.compactMap {
                let artists = $0.artists?.compactMap { return $0.name }
                return TrackTableViewCellModel(name: $0.name,
                                               artist: artists?.joined(separator: ", "),
                                               image: data.images?.first?.url)
            }
        } else {
            tracksViewModel = []
            view?.displayLabel(with: "Unfortunately, this playlist is empty...")
        }
    
        view?.setupData(AlbumTableViewHeaderFooterViewModel(imageUrl: data.images?.first?.url,
                                                name: data.name),
                        tracks: tracksViewModel)
        
        view?.reloadData()
    }
    
    func interactorFailedToFetchAlbum() {
        view?.displayLabel(with: "Oops, something went wrong... \n Pull down to reload view")
    }
}
