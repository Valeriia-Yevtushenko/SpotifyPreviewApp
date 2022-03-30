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
    func interactorDidGetCurrentPlayingTrack(with track: PlayerItem) {
        view?.setupPlayer(with: track)
    }
    
    func interactorFailedToGetCurrentPlayingTrack() {
        
    }
    
}

extension MiniPlayerPresenter: MiniPlayerModuleInput {
    func refreshMiniPlayer() {
        interactor?.getCurrentPlayingTrack()
    }
}
