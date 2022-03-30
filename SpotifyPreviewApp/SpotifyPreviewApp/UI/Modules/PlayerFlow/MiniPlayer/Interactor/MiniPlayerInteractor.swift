//
//  MiniPlayerInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 29.03.2022.
//

import Foundation

class MiniPlayerInteractor {
    var playerService: PlayerServiceProtocol!
    weak var presenter: MiniPlayerInteractorOutputProtocol?
}

extension MiniPlayerInteractor: MiniPlayerInteractorInputProtocol {
    func getCurrentPlayingTrack() {
        playerService.setupDelegate(self)
        
        guard let item = playerService.currentPlaiyngItem else {
            presenter?.interactorFailedToGetCurrentPlayingTrack()
            return
        }
        
        presenter?.interactorDidGetCurrentPlayingTrack(with: item)
    }
    
    func next() {
        playerService.next()
            .done { item in
                self.presenter?.interactorDidGetCurrentPlayingTrack(with: item)
            }.catch { _ in
                
            }
    }

    func togglePlayPause() {
        playerService.togglePlayPause()
    }
}

extension MiniPlayerInteractor: PlayerServiceDelegate {
    func audioPlayerDidFinishPlaying() {
        playerService.next()
            .done { item in
                self.presenter?.interactorDidGetCurrentPlayingTrack(with: item)
            }.catch { _ in
                
            }
    }
}
