//
//  PlayerPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 06.03.2022.
//

import Foundation

protocol PlayerViewInputProtocol: AnyObject {
    func setupPlayer(with item: PlayerItem)
    func setupPlayer(with item: PlayerItem, isPlaying: Bool)
    func setupListOfTracks(_ tracks: [TrackTableViewCellModel])
    func refreshPlayerTime(_ time: Double)
    func displayErrorAlert()
    func stopPlayer()
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
    func viewDidTapShowListOfTracks()
    func viewDidChangePlayerItem(_ index: Int)
    func viewDidTapDismiss(with success: Bool)
}

protocol PlayerModuleOutput: AnyObject {
    func dismissPlayer(with success: Bool)
}
