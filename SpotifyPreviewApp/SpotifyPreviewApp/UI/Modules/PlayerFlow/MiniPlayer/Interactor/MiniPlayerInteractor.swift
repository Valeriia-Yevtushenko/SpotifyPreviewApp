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
    func refresh() {
        playerService.setupDelegate(self)
        
        guard let item = playerService.currentPlaiyngItem else {
            presenter?.interactorFailedToGetCurrentPlayingTrack()
            return
        }
        
        presenter?.interactorDidRefresh(track: item, isPlaying: playerService.isPlaying)
    }
    
    func getCurrentPlayingTrack() {
        guard let item = playerService.currentPlaiyngItem else {
            presenter?.interactorFailedToGetCurrentPlayingTrack()
            return
        }
        
        presenter?.interactorDidGetCurrentPlayingTrack(item)
    }
    
    func next() {
        playerService.next()
            .done { item in
                self.presenter?.interactorDidGetCurrentPlayingTrack(item)
            }.catch { _ in
                
            }
    }

    func togglePlayPause() {
        playerService.togglePlayPause()
    }
}

extension MiniPlayerInteractor: PlayerServiceDelegate {
    func audioPlayerPlayesLastItem() {
        presenter?.interactorDidPlayLastTrack()
    }
    
    func audioPlayerDidFinishPlaying() {
        playerService.next()
            .done { item in
                self.presenter?.interactorDidGetCurrentPlayingTrack(item)
            }.catch { _ in
                
            }
    }
}
