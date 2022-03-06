//
//  AlbumInteractor.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation
import PromiseKit

class AlbumInteractor {
    private var album: Album?
    var networkService: NetworkServiceProtocol!
    var urlBuilder: URLBuilderProtocol!
    var identifier: String!
    weak var presenter: AlbumInteractorOutputProtocol?
}

extension AlbumInteractor: AlbumInteractorInputProtocol {
    func fetchAlbum() {
        let promise: Promise<Album> = networkService.fetch(urlBuilder
                                                                .with(path: .album)
                                                                .with(pathParameter: identifier)
                                                                .build())
        
        promise.done { album in
            self.presenter?.interactorDidFetchAlbum(album)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchAlbum()
        }
    }
}
