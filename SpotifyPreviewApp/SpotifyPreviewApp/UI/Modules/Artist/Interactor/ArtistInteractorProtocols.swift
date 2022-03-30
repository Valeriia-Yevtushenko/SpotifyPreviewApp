//
//  ArtistInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import Foundation

protocol ArtistInteractorInputProtocol: AnyObject {
    func fetchArtistInfo()
    func followOnArtist()
    func unfollowArtist()
    func getAlbumId(at index: Int)
    func getPlaylist(for index: Int)
}

protocol ArtistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchArtistInfo(_ artistInfo: (Artist?, [Track], [Album]))
    func interactorDidGetArtistStatus(_ status: ArtistStatus)
    func interactorDidGetPlaylist(tracks: [Track], for index: Int)
    func interactorDidFollowOnArtist()
    func interactorUnfollowArtist()
    func interactorDidGetAlbumId(_ identifier: String)
    func interactorFailedToFetchArtistInfo()
    func interactorFailedToFollowOnArtist(_ error: String)
    func interactorFailedToUnfollowArtist(_ error: String)
}
