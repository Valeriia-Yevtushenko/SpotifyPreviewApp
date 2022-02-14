//
//  ArtistInteractor.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import Foundation
import PromiseKit

final class ArtistInteractor {
    private var artistInfo: (Artist?, [Track], [Album]) = (nil, [], [])
    weak var presenter: ArtistInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol!
    var identifier: String!
}

extension ArtistInteractor: ArtistInteractorInputProtocol {
    func fetchArtistInfo() {
        let promise: Promise<Artist> = networkService.fetch(Request.artist.createUrl(data: identifier))
        
        firstly {
            promise
        }.then { artist -> Promise<Tracks> in
            self.artistInfo.0 = artist
            return self.networkService.fetch(Request.artistTopTrack.createUrl(data: self.identifier))
        }.compactMap { tracks in
            return tracks.tracks
        }.then { tracks -> Promise<Albums> in
            self.artistInfo.1 = tracks
            return self.networkService.fetch(Request.artistAlbums.createUrl(data: self.identifier))
        }.compactMap { albums in
            return albums.items
        }.done { albums in
            self.artistInfo.2 = albums
            self.presenter?.interactorDidFetchArtistInfo(self.artistInfo)
        }.catch { _ in
            self.presenter?.interactorFailedToFetchArtistInfo()
        }
    }
}
