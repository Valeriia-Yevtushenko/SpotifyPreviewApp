//
//  AlbumPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

protocol AlbumViewInputProtocol: AnyObject {
    func setupData(_ info: AlbumTableViewHeaderFooterViewModel, tracks: [TrackTableViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
}

protocol AlbumViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewWillDisappear()
    func viewDidRefresh()
    func viewSelectedItem(at index: Int)
    func viewDidTapPlay()
    func viewDidTapShuffle()
}

protocol AlbumModuleOutput: AnyObject {
    func runPlayerFlow(with tracks: [Track], for index: Int)
    func finishFlow()
}
