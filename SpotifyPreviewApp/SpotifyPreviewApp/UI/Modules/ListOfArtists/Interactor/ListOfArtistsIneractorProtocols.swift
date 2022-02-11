//
//  ListOfArtistsIneractorProtocols.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

protocol ListOfArtistsInteractorInputProtocol: AnyObject {
    func fetchArtists()
    func getArtistId(at index: Int)
}

protocol ListOfArtistsInteractorOutputProtocol: AnyObject {
    func interactorDidFetchArtists(_ data: Playlists)
    func interactorFailedToFetchArtists()
    func interactorDidGetPlaylistId(_ identifier: String)
}
