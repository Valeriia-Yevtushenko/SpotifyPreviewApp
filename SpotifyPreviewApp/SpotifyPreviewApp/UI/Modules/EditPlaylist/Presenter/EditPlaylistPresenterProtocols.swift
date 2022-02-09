//
//  EditPlaylistPresenterProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import Foundation

protocol EditPlaylistViewInputProtocol: AnyObject {
    func setupPlaylistInfo(_ model: EditPlaylistViewControllerModel)
    func displayErrorAlert(with text: String)
}

protocol EditPlaylistViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidTapCancel()
    func viewDidTapSavePlaylist(with info: NewPlaylist?, image: Data?)
}

protocol EditPlaylistModuleOutput {
    func backToPlaylist()
    func finishedFlow()
}
