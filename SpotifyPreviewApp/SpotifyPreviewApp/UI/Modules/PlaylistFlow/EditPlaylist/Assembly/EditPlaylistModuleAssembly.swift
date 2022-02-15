//
//  EditPlaylistModuleAssembly.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import UIKit

class EditPlaylistModuleAssembly {
    func createModule(with playlist: Playlist, serviceManager: ServiceManagerProtocol) -> (UIViewController, EditPlaylistPresenter) {
        let playlistViewController = EditPlaylistViewController.instantiate(from: EditPlaylistViewController.identifier)
        let presenter = EditPlaylistPresenter()
        let interactor = EditPlaylistInteractor()
        interactor.networkService = serviceManager.network()
        interactor.presenter = presenter
        interactor.playlist = playlist
        presenter.interactor = interactor
        presenter.view = playlistViewController
        playlistViewController.output = presenter
        return (playlistViewController, presenter)
    }
}
