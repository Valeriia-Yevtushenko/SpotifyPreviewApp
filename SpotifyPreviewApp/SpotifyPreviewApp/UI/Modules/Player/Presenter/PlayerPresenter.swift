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
    func interactorDidRefreshPlayerTime(_ time: Double) {
        view?.refreshPlayerTime(time)
    }
    
    func interactorDidPlay(with track: PlayerItem) {
        view?.setupPlayer(with: track)
    }
}
