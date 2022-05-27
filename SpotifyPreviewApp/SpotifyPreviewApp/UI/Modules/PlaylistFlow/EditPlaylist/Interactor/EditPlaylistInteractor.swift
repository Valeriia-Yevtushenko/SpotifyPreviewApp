//
//  EditPlaylistInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 06.02.2022.
//

import Foundation
import PromiseKit

class EditPlaylistInteractor {
    weak var presenter: EditPlaylistInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    var playlist: Playlist!
}

extension EditPlaylistInteractor: EditPlaylistInteractorInputProtocol {
    func updatePlaylist(with info: NewPlaylist?, image: Data?) {
        guard let identifier = playlist?.identifier else {
            self.presenter?.interactorFailedToUpdatePlaylist("Unknown error, please try again later")
            return
        }
        
        let updateInfoUrl = urlBuilder
            .with(path: .playlist)
            .with(pathParameter: identifier)
            .build()
        let updateImageUrl = urlBuilder
            .with(path: .playlistImage)
            .with(pathParameter: identifier)
            .build()
        
        if let info = info, let data = try? JSONEncoder().encode(info), let image = image {
            firstly {
                self.networkService.put(data: data,
                                        url: updateInfoUrl)
            }.then { _ in
                self.networkService.put(data: image,
                                        header: ["Content-Type": "image/jpeg"],
                                        url: updateImageUrl)
            }.done { _ in
                self.presenter?.interactorDidUpdatePlaylist()
            }.catch { error in
                self.presenter?.interactorFailedToUpdatePlaylist(error.localizedDescription)
            }
        } else if let info = info, let data = try? JSONEncoder().encode(info) {
            self.networkService.put(data: data,
                                    url: updateInfoUrl)
                .done({ _ in
                    self.presenter?.interactorDidUpdatePlaylist()
                }).catch { error in
                    self.presenter?.interactorFailedToUpdatePlaylist(error.localizedDescription)
                }
        } else if let image = image {
            self.networkService.put(data: image,
                                    header: ["Content-Type": "image/jpeg"],
                                    url: updateImageUrl)
                .done({ _ in
                    self.presenter?.interactorDidUpdatePlaylist()
                }).catch { error in
                    self.presenter?.interactorFailedToUpdatePlaylist(error.localizedDescription)
                }
        } else {
            self.presenter?.interactorFailedToUpdatePlaylist("Unknown error, please try again later")
        }
    }
    
    func getPlaylist() {
        presenter?.interactorDidGetPlaylist(playlist)
    }
}
