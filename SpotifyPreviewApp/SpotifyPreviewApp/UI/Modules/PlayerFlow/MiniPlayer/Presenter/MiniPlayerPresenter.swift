//
//  MiniPlayerPresenter.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 29.03.2022.
//

import Foundation

class MiniPlayerPresenter {
    weak var view: MiniPlayerViewInputProtocol?
    var interactor: MiniPlayerInteractorInputProtocol?
    var coordinator: MiniPlayerModuleOutput?
}

extension MiniPlayerPresenter: MiniPlayerViewOutputProtocol {
    func viewDidTapOpenPlayer() {
        coordinator?.openPlayer()
    }
    
    func viewDidLoad() {
        interactor?.getCurrentPlayingTrack()
    }
    
    func viewDidTapNext() {
        interactor?.next()
    }
    
    func viewDidTapTogglePlayPause() {
        interactor?.togglePlayPause()
    }
}

extension MiniPlayerPresenter: MiniPlayerInteractorOutputProtocol {
    func interactorDidPlayLastTrack() {
        view?.stopPlayer()
    }
    
    func interactorDidRefresh(track: PlayerItem, isPlaying: Bool) {
        view?.updatePlayer(with: track, isPlaying: isPlaying)
    }
    
    func interactorDidGetCurrentPlayingTrack(_ track: PlayerItem) {
        view?.setupPlayer(with: track)
    }
    
    func interactorFailedToGetCurrentPlayingTrack() {
        view?.displayErrorAlert()
    }
}

extension MiniPlayerPresenter: MiniPlayerModuleInput {
    func refreshMiniPlayer() {
        interactor?.refresh()
    }
}
