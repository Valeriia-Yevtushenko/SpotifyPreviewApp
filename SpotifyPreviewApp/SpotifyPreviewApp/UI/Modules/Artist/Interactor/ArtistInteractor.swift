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
    var identifier: String!
    var status: ArtistStatus!
    var networkService: NetworkServiceProtocol!
    var databaseManager: RealmDatabaseService!
    var urlBuilder: URLBuilderProtocol!
    weak var presenter: ArtistInteractorOutputProtocol?
}

extension ArtistInteractor: ArtistInteractorInputProtocol {
    func saveTrack(at index: Int) {
        DispatchQueue.global(qos: .userInteractive).async {
            let track = self.artistInfo.1[index]
            let trackModel = TrackModel()
            trackModel.uri = track.uri
            trackModel.name = track.name
            trackModel.identifier = track.identifier
            trackModel.extetnalUrl = track.externalUrls.spotify
            trackModel.albumId = track.album?.identifier ?? ""
            trackModel.artistId = track.artists?.first?.identifier ?? ""
            trackModel.artists = track.artists?.compactMap { $0.name }.joined(separator: ", ") ?? ""
            
            if let image = URL(string: track.album?.images?.first?.url ?? "") {
                trackModel.image = try? Data(contentsOf: image)
            }
            
            if let data = URL(string: track.previewUrl ?? "") {
                trackModel.data = try? Data(contentsOf: data)
            }
            
            DispatchQueue.main.async {
                self.databaseManager.save(trackModel)
            }
        }
    }
    
    func getArtistURL() {
        guard let url = artistInfo.0?.externalUrls?.spotify else {
            return
        }
        
        presenter?.interactorDidGetURL(url)
    }
    
    func getTrackAlbumId(for index: Int) {
        presenter?.interactorDidGetTrackAlbumId(artistInfo.1[index].album?.identifier ?? "")
    }
    
    func getTrackUri(for index: Int) {
        presenter?.interactorDidGetTrackUri(artistInfo.1[index].uri)
    }
    
    func getTrackURL(for index: Int) {
        presenter?.interactorDidGetURL(artistInfo.1[index].externalUrls.spotify)
    }
    
    func getPlaylist(for index: Int) {
        presenter?.interactorDidGetPlaylist(tracks: artistInfo.1, for: index)
    }
    
    func getAlbumId(at index: Int) {
        presenter?.interactorDidGetAlbumId(artistInfo.2[index].identifier)
    }
    
    func followOnArtist() {
        guard let artistId = artistInfo.0?.identifier,
              let jsonData = try? JSONSerialization.data(withJSONObject: ["ids": [artistId]]) else {
            return
        }
        
        networkService.put(data: jsonData,
                           url: urlBuilder
                            .with(path: .following)
                            .with(queryItems: ["type": "artist",
                                               "ids": artistId])
                            .build())
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
        
        networkService.delete(url: urlBuilder
                                .with(path: .following)
                                .with(queryItems: ["type": "artist",
                                                   "ids": artistId])
                                .build())
            .done { _ in
                self.presenter?.interactorUnfollowArtist()
            }.catch { error in
                self.presenter?.interactorFailedToUnfollowArtist(error.localizedDescription)
            }
    }

    func fetchArtistInfo() {
        let promise: Promise<Artist> = networkService.fetch(urlBuilder
                                                                .with(path: .artist)
                                                                .with(pathParameter: identifier)
                                                                .build())
        
        firstly {
            promise
        }.then { artist -> Promise<Tracks> in
            self.artistInfo.0 = artist
            return self.networkService.fetch(self.urlBuilder
                                                .with(path: .artistTopTrack)
                                                .with(pathParameter: self.identifier)
                                                .with(queryItems: ["market": "us"])
                                                .build())
        }.compactMap { tracks in
            return tracks.tracks
        }.then { tracks -> Promise<Albums> in
            self.artistInfo.1 = tracks
            return self.networkService.fetch(self.urlBuilder
                                                .with(path: .artistAlbums)
                                                .with(pathParameter: self.identifier)
                                                .with(queryItems: ["limit": "5"])
                                                .build())
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
        
        let isUserFollows: Promise<[Bool]> = networkService.fetch(urlBuilder
                                                                    .with(path: .isFolowing)
                                                                    .with(queryItems: ["type": "artist",
                                                                                       "ids": identifier])
                                                                    .build())
        
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
