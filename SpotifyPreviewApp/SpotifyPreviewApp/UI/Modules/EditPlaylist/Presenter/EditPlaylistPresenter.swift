//
//  EditPlaylistPresenter.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import Foundation

class EditPlaylistPresenter {
    weak var view: EditPlaylistViewInputProtocol?
    var coordinator: EditPlaylistModuleOutput?
    var interactor: EditPlaylistInteractorInputProtocol?
}

extension EditPlaylistPresenter: EditPlaylistViewOutputProtocol {
    func viewDidTapCancel() {
        coordinator?.backToPlaylist()
    }
    
    func viewDidTapSavePlaylist(with info: NewPlaylist?, image: Data?) {
        interactor?.updatePlaylist(with: info, image: image)
    }
    
    func viewDidLoad() {
        interactor?.getPlaylist()
    }
}

extension EditPlaylistPresenter: EditPlaylistInteractorOutputProtocol {
    func interactorDidUpdatePlaylist() {
        coordinator?.backToPlaylist()
    }
    
    func interactorFailedToUpdatePlaylist(_ error: String) {
        view?.displayErrorAlert(with: error)
    }
    
    func interactorDidGetPlaylist(_ playlist: Playlist) {
        view?.setupPlaylistInfo(EditPlaylistViewControllerModel(name: playlist.name ?? "",
                                                                description: playlist.description ?? "",
                                                                imageUrl: playlist.images?.first?.url,
                                                                isPublic: playlist.isPublic ?? true))
    }
}
