//
//  PlayerInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import Foundation

protocol PlayerInteractorInputProtocol: AnyObject {
    func play()
    func play(at: Double)
    func next()
    func previous()
    func toggleRepeat()
    func shuffle()
    func togglePlayPause()
    func refreshPlayerTime()
}

protocol PlayerInteractorOutputProtocol: AnyObject {
    func interactorDidPlay(with track: PlayerItem)
    func interactorDidRefreshPlayerTime(_ time: Double)
}
