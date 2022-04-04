//
//  PlayerInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import Foundation

class PlayerInteractor {
    var tracks: [Track]!
    var index: Int!
    var isOpeningFromMiniPlayer: Bool = false
    var playerService: PlayerServiceProtocol!
    weak var presenter: PlayerInteractorOutputProtocol?
}

extension PlayerInteractor: PlayerInteractorInputProtocol {
    func play(at index: Int) {
        playerService.play(at: index)
            .done { item in
                self.presenter?.interactorDidPlay(with: item)
            }.catch { _ in
                self.presenter?.interactorFailedToPlay()
            }
    }
    
    func getListOfTracks() {
        presenter?.interactorDidGetListOfTracks(playerService.currentListOfPlayerItems)
    }
    
    func refreshPlayerTime() {
        presenter?.interactorDidRefreshPlayerTime(playerService.currentTime)
    }
    
    func play() {
        if isOpeningFromMiniPlayer {
            guard let item = playerService.currentPlaiyngItem else {
                self.presenter?.interactorFailedToPlay()
                return
            }
            
            self.presenter?.interactorDidGetCurrentPlayingTrack(item, isPlaying: playerService.isPlaying)
        } else {
            let items: [PlayerItem] = tracks.compactMap {
                let artist = $0.artists?.compactMap { return $0.name }
                return PlayerItem(duration: nil,
                                  url: $0.previewUrl,
                                  image: $0.album?.images?.first?.url,
                                  title: $0.name,
                                  artists: artist?.joined(separator: ", "))
            }
            
            playerService.play(with: items, at: index)
                .done { item in
                    self.presenter?.interactorDidPlay(with: item)
                }.catch { _ in
                    self.presenter?.interactorFailedToPlay()
                }
        }
    }
    
    func play(at time: Double) {
        playerService.play(at: time)
    }
    
    func next() {
        playerService.next()
            .done { item in
                self.presenter?.interactorDidPlay(with: item)
            }.catch { _ in
                self.presenter?.interactorFailedToPlay()
            }
    }
    
    func previous() {
        playerService.previous()
            .done { item in
                self.presenter?.interactorDidPlay(with: item)
            }.catch { _ in
                self.presenter?.interactorFailedToPlay()
            }
    }
    
    func toggleRepeat() {
        playerService.toggleRepeat()
    }
    
    func shuffle() {
        playerService.shuffle()
            .done { item in
                self.presenter?.interactorDidPlay(with: item)
            }.catch { _ in
                self.presenter?.interactorFailedToPlay()
            }
    }
    
    func togglePlayPause() {
        playerService.togglePlayPause()
    }
}

extension PlayerInteractor: PlayerServiceDelegate {
    func audioPlayerPlayesLastItem() {
        presenter?.interactorDidPlayLastTrack()
    }
    
    func audioPlayerDidFinishPlaying() {
        playerService.next()
            .done { item in
                self.presenter?.interactorDidPlay(with: item)
            }.catch { _ in
                self.presenter?.interactorFailedToPlay()
            }
    }
}
