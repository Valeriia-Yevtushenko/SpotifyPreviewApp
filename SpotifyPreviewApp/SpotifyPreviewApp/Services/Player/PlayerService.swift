//
//  PlayerService.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 19.03.2022.
//

import AVFoundation
import PromiseKit

protocol PlayerServiceDelegate: AnyObject {
    func audioPlayerDidFinishPlaying()
}

enum PlayerError: Error {
    case url
}

class PlayerService: NSObject {
    private var player: AVAudioPlayer?
    private var playerItems: [PlayerItem] = []
    private var currentIndex = 0
    weak var delegate: PlayerServiceDelegate?
    
    override init() {
        super.init()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }

    private func play() -> Promise<PlayerItem> {
        return Promise { seal in
            guard let url = URL(string: playerItems[currentIndex].url ?? ""),
                  let data = try? Data(contentsOf: url) else {
                      seal.reject(PlayerError.url)
                return
            }
            var item = playerItems[currentIndex]
            player = try? AVAudioPlayer(data: data)
            player?.delegate = self
            item.duration = player?.duration
            seal.fulfill(item)
            player?.play()
        }
    }
}

extension PlayerService: PlayerServiceProtocol {
    var currentListOfPlayerItems: [PlayerItem] {
        return playerItems
    }
    
    var currentTime: Double {
        return player?.currentTime ?? 0
    }
    
    func setupDelegate(_ delegate: PlayerServiceDelegate) {
        self.delegate = delegate
    }
    
    func play(with items: [PlayerItem], at index: Int) -> Promise<PlayerItem> {
        playerItems = items
        currentIndex = index
        return play()
    }

    func play(at time: Double) {
        player?.pause()
        player?.currentTime = time
        self.player?.play()
    }
    
    func next() -> Promise<PlayerItem> {
        if currentIndex < playerItems.count {
            currentIndex += 1
        }
        
        return play()
    }
    
    func previous() -> Promise<PlayerItem> {
        if currentIndex > 0 {
            currentIndex -= 1
        }
        
        return play()
    }
    
    func shuffle() -> Promise<PlayerItem> {
        playerItems.shuffle()
        return play()
    }
    
    func toggleRepeat() {
        guard player?.numberOfLoops == -1 else {
            player?.numberOfLoops = -1
            return
        }
        
        player?.numberOfLoops = 0
    }
    
    func togglePlayPause() {
        if player?.isPlaying == true {
            player?.pause()
        } else {
            player?.play()
        }
    }
}

extension PlayerService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.audioPlayerDidFinishPlaying()
    }
}
