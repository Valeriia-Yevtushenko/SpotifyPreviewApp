//
//  MiniPlayerInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 29.03.2022.
//

import Foundation

protocol MiniPlayerInteractorInputProtocol: AnyObject {
    func getCurrentPlayingTrack()
    func next()
    func refresh()
    func togglePlayPause()
}

protocol MiniPlayerInteractorOutputProtocol: AnyObject {
    func interactorDidPlayLastTrack()
    func interactorDidGetCurrentPlayingTrack(_ track: PlayerItem)
    func interactorDidRefresh(track: PlayerItem, isPlaying: Bool)
    func interactorFailedToGetCurrentPlayingTrack()
}
