//
//  AlbumPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

protocol AlbumViewInputProtocol: AnyObject {
    func setupData(_ info: AlbumTableViewCellModel, tracks: [TrackTableViewCellModel])
    func reloadData()
    func displayLabel(with text: String)
}

protocol AlbumViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewWillDisappear()
    func viewDidRefresh()
    func viewSelectedItem(at index: Int)
}

protocol AlbumModuleOutput: AnyObject {
    func finishFlow()
}
