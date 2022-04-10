//
//  PlayerService.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 19.03.2022.
//

import AVFoundation
import MediaPlayer
import PromiseKit

protocol PlayerServiceDelegate: AnyObject {
    func audioPlayerDidFinishPlaying()
    func audioPlayerPlayesLastItem()
}

enum PlayerError: Error {
    case url
    case empty
}

class PlayerService: NSObject {
    private var player: AVAudioPlayer?
    private var playerItems: [PlayerItem] = []
    private var currentIndex = 0
    weak var delegate: PlayerServiceDelegate?
    
    func configure() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
            setupNowPlayingInfoCenter()
        } catch {
            print(error)
        }
    }
}

private extension PlayerService {
    func setupNowPlayingInfoCenter() {
        MPRemoteCommandCenter.shared().playCommand.addTarget { _ in
            self.togglePlayPause()
            self.updateNowPlayingInfoCenter()
            return .success
        }
        MPRemoteCommandCenter.shared().pauseCommand.addTarget { _ in
            self.togglePlayPause()
            return .success
        }
        MPRemoteCommandCenter.shared().nextTrackCommand.addTarget { _ in
            var result: MPRemoteCommandHandlerStatus = .success
            
            self.next().done { _ in
                result = .success
            }.catch { _ in
                result = .noSuchContent
            }
            
            self.updateNowPlayingInfoCenter()
            return result
        }
        MPRemoteCommandCenter.shared().previousTrackCommand.addTarget { _ in
            var result: MPRemoteCommandHandlerStatus = .success
            
            self.previous().done { _ in
                result = .success
            }.catch { _ in
                result = .noSuchContent
            }
            
            self.updateNowPlayingInfoCenter()
            return result
        }
    }
    
    func play() -> Promise<PlayerItem> {
        return Promise { seal in
            guard !playerItems.isEmpty else {
                seal.reject(PlayerError.empty)
                player?.stop()
                return
            }
            
            let dataForPlayer: Data
            
            if  let url = URL(string: playerItems[currentIndex].url ?? ""),
                let data = try? Data(contentsOf: url) {
                dataForPlayer = data
                player = try? AVAudioPlayer(data: dataForPlayer)
            } else if let data = playerItems[currentIndex].data {
                dataForPlayer = data
                player = try? AVAudioPlayer(data: dataForPlayer)
            } else {
                seal.reject(PlayerError.url)
                player?.stop()
            }
           
            var item = playerItems[currentIndex]
            player?.delegate = self
            item.duration = player?.duration
            updateNowPlayingInfoCenter()
            seal.fulfill(item)
            player?.play()
        }
    }
    
    func updateNowPlayingInfoCenter() {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            let currentItem = self.playerItems[currentIndex]
            var info = [String: Any]()
            info = [
                MPMediaItemPropertyTitle: currentItem.title ?? "",
                MPMediaItemPropertyArtist: currentItem.artists ?? "",
                MPMediaItemPropertyPlaybackDuration: self.player?.duration ?? "",
                MPNowPlayingInfoPropertyElapsedPlaybackTime: self.player?.currentTime ?? ""
            ]
            
            if let data = currentItem.imageData,
               let image = UIImage(data: data) {
                info[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { _ in
                        return image
                    })
            } else if let imageUrl = currentItem.image,
                      let url = URL(string: imageUrl),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) {
                info[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { _ in
                        return image
                    })
            }
            
            DispatchQueue.main.async {
                MPNowPlayingInfoCenter.default().nowPlayingInfo = info
            }
        }
    }
}

extension PlayerService: PlayerServiceProtocol {
    var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    
    var currentPlaiyngItem: PlayerItem? {
        guard !playerItems.isEmpty else {
            return nil
        }
        
        return playerItems[currentIndex]
    }
    
    var currentListOfPlayerItems: [PlayerItem] {
        return playerItems
    }
    
    var currentTime: Double {
        return player?.currentTime ?? 0
    }
    
    func setupDelegate(_ delegate: PlayerServiceDelegate) {
        self.delegate = delegate
    }
    
    func play(at index: Int) -> Promise<PlayerItem> {
        currentIndex = index
        return play()
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
        if currentIndex < (playerItems.count - 1) {
            currentIndex += 1
        }
        
        player?.stop()
        return play()
    }
    
    func previous() -> Promise<PlayerItem> {
        if currentIndex > 0 {
            currentIndex -= 1
        }
        
        player?.stop()
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
        if currentIndex == (playerItems.count - 1) {
            delegate?.audioPlayerPlayesLastItem()
        } else {
            delegate?.audioPlayerDidFinishPlaying()
        }
    }
}
