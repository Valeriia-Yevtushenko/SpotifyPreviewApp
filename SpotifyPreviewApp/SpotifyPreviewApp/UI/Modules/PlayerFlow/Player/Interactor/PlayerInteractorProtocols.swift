//
//  PlayerInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import Foundation

protocol PlayerInteractorInputProtocol: AnyObject {
    func play()
    func play(at index: Int)
    func play(at: Double)
    func next()
    func previous()
    func toggleRepeat()
    func shuffle()
    func togglePlayPause()
    func refreshPlayerTime()
    func getListOfTracks()
}

protocol PlayerInteractorOutputProtocol: AnyObject {
    func interactorDidPlayLastTrack()
    func interactorDidPlay(with track: PlayerItem)
    func interactorDidGetCurrentPlayingTrack(_ track: PlayerItem, isPlaying: Bool)
    func interactorFailedToPlay()
    func interactorDidGetListOfTracks(_ tracks: [PlayerItem])
    func interactorDidRefreshPlayerTime(_ time: Double)
}
