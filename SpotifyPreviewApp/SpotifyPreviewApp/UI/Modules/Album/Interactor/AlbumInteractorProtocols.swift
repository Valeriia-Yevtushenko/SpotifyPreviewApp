//
//  AlbumInteractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 17.02.2022.
//

import Foundation

protocol AlbumInteractorInputProtocol: AnyObject {
    func fetchAlbum()
}

protocol AlbumInteractorOutputProtocol: AnyObject {
    func interactorDidFetchAlbum(_ data: Album)
    func interactorFailedToFetchAlbum()
}
