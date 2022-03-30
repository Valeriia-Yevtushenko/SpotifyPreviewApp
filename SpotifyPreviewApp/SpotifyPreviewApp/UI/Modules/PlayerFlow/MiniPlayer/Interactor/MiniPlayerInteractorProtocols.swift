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
    func togglePlayPause()
}

protocol MiniPlayerInteractorOutputProtocol: AnyObject {
    func interactorDidGetCurrentPlayingTrack(with track: PlayerItem)
    func interactorFailedToGetCurrentPlayingTrack()
}
