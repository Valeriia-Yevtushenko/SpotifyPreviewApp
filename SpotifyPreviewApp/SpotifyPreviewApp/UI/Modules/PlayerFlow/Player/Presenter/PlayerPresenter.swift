//
//  PlayerPresenter.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import Foundation

class PlayerPresenter {
    weak var view: PlayerViewInputProtocol?
    var interactor: PlayerInteractorInputProtocol?
    var coordinator: PlayerModuleOutput?
}

extension PlayerPresenter: PlayerViewOutputProtocol {
    func viewDidChangePlayerItem(_ index: Int) {
        interactor?.play(at: index)
    }
    
    func viewDidTapDismiss(with success: Bool) {
        coordinator?.dismissPlayer(with: success)
    }
    
    func viewDidTapShowListOfTracks() {
        interactor?.getListOfTracks()
    }
    
    func viewNeedToRefreshPlayerTime() {
        interactor?.refreshPlayerTime()
    }
    
    func viewDidChangePlayerTime(_ time: Double) {
        interactor?.play(at: time)
    }
    
    func viewDidLoad() {
        interactor?.play()
    }
    
    func viewDidTapNext() {
        interactor?.next()
    }
    
    func viewDidTapPrevious() {
        interactor?.previous()
    }
    
    func viewDidTapToggleRepeat() {
        interactor?.toggleRepeat()
    }
    
    func viewDidTapShuffle() {
        interactor?.shuffle()
    }
    
    func viewDidTapTogglePlayPause() {
        interactor?.togglePlayPause()
    }
}

extension PlayerPresenter: PlayerInteractorOutputProtocol {
    func interactorDidGetCurrentPlayingTrack(_ track: PlayerItem, isPlaying: Bool) {
        view?.setupPlayer(with: track, isPlaying: isPlaying)
    }
    
    func interactorDidPlayLastTrack() {
        view?.stopPlayer()
    }
    
    func interactorFailedToPlay() {
        view?.displayErrorAlert()
    }
    
    func interactorDidGetListOfTracks(_ tracks: [PlayerItem]) {
        let tracks: [TrackTableViewCellModel] = tracks.map {
            return TrackTableViewCellModel(name: $0.title,
                                           artist: $0.artists,
                                           image: $0.image)
        }
        
        view?.setupListOfTracks(tracks)
    }
    
    func interactorDidRefreshPlayerTime(_ time: Double) {
        view?.refreshPlayerTime(time)
    }
    
    func interactorDidPlay(with track: PlayerItem) {
        view?.setupPlayer(with: track)
    }
}
