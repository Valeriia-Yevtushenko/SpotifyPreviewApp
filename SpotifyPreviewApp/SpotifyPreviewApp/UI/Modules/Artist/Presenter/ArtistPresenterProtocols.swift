//
//  ArtistPresenterProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import Foundation

protocol ArtistViewInputProtocol: AnyObject {
    func setupArtistInfo(_ data: ArtistInfoViewModel)
    func setupArtistStatus(_ status: ArtistStatus)
    func reloadData()
    func displayLabel(with text: String)
    func showConfirmationToastView()
    func displayErrorAlert(with text: String)
}

protocol ArtistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapFollow()
    func viewDidTapUnfollow()
    func viewDidTapOnAlbum(at index: Int)
    func viewDidRefresh()
}

protocol ArtistModuleOutput: AnyObject {
    func runAlbumFlow(with identifier: String)
}
