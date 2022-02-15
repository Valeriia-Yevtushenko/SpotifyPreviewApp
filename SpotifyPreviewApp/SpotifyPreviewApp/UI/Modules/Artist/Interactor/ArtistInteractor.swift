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
    var status: ArtistStatus!
}

extension ArtistInteractor: ArtistInteractorInputProtocol {
    func followOnArtist() {
        guard let artistId = artistInfo.0?.identifier,
              let jsonData = try? JSONSerialization.data(withJSONObject: ["ids": [artistId]]) else {
            return
        }
        
        networkService.put(data: jsonData,
                           url: Request.followOnArtist.createUrl(data: artistId))
            .done {_ in
                self.presenter?.interactorDidFollowOnArtist()
            }.catch { error in
                self.presenter?.interactorFailedToFollowOnArtist(error.localizedDescription)
            }
    }
    
    func unfollowArtist() {
        guard let artistId = artistInfo.0?.identifier else {
            return
        }
        
        networkService.delete(url: Request.followOnArtist.createUrl(data: artistId))
            .done { _ in
                self.presenter?.interactorUnfollowArtist()
            }.catch { error in
                self.presenter?.interactorFailedToUnfollowArtist(error.localizedDescription)
            }
    }

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
        
        guard status != ArtistStatus.followed else {
            presenter?.interactorDidGetArtistStatus(.followed)
            return
        }
        
        let isUserFollows: Promise<[Bool]> = networkService.fetch(Request.isUserFollowsArtist.createUrl(data: self.identifier))
        
        isUserFollows.done { result in
            if result.first == true {
                self.presenter?.interactorDidGetArtistStatus(.followed)
            } else {
                self.presenter?.interactorDidGetArtistStatus(.unfollowed)
            }
        }.catch { _ in
            self.presenter?.interactorDidGetArtistStatus(.unknown)
        }
    }
}
