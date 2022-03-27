//
//  PlayerPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import Foundation

protocol PlayerViewInputProtocol: AnyObject {
    func setupPlayer(with item: PlayerItem)
    func refreshPlayerTime(_ time: Double)
}

protocol PlayerViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapNext()
    func viewDidTapPrevious()
    func viewDidTapToggleRepeat()
    func viewDidTapShuffle()
    func viewDidTapTogglePlayPause()
    func viewDidChangePlayerTime(_ time: Double)
    func viewNeedToRefreshPlayerTime()
}

protocol PlayerModuleOutput: AnyObject {
    
}
