//
//  PlayerServiceProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 27.03.2022.
//

import Foundation
import PromiseKit

protocol PlayerServiceProtocol: AnyObject {
    func setupDelegate(_ delegate: PlayerServiceDelegate)
    func play(with items: [PlayerItem], at index: Int) -> Promise<PlayerItem>
    func play(at time: Double)
    func togglePlayPause()
    func next() -> Promise<PlayerItem>
    func previous() -> Promise<PlayerItem>
    func shuffle() -> Promise<PlayerItem>
    func toggleRepeat()
    func refreshPlayerTime() -> Double
}
