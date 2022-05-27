//
//  MiniPlayerPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 29.03.2022.
//

import Foundation

protocol MiniPlayerViewInputProtocol: AnyObject {
    func setupPlayer(with item: PlayerItem)
    func updatePlayer(with item: PlayerItem, isPlaying: Bool)
    func displayErrorAlert()
    func stopPlayer()
}

protocol MiniPlayerViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapNext()
    func viewDidTapTogglePlayPause()
    func viewDidTapOpenPlayer() 
}

protocol MiniPlayerModuleOutput: AnyObject {
    func hideMiniPlayer()
    func openPlayer()
}

protocol MiniPlayerModuleInput: AnyObject {
    func refreshMiniPlayer()
}
