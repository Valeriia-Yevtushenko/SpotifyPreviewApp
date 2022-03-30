//
//  MiniPlayerPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 29.03.2022.
//

import Foundation

protocol MiniPlayerViewInputProtocol: AnyObject {
    func setupPlayer(with item: PlayerItem)
}

protocol MiniPlayerViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapNext()
    func viewDidTapTogglePlayPause()
}

protocol MiniPlayerModuleOutput: AnyObject {
    
}

protocol MiniPlayerModuleInput: AnyObject {
    func refreshMiniPlayer()
}
