//
//  PlaylistsInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 24.05.2021.
//

import Foundation

protocol ListOfPlaylistsInteractorInputProtocol: AnyObject {
    func fetchData()
    func getData(at index: Int)
}

protocol ListOfPlaylistsInteractorOutputProtocol: AnyObject {
    func interactorDidFetchData(_ data: Playlists)
    func interactorFailedToFetchData()
    func interactorDidGetData(_ data: String)
}
