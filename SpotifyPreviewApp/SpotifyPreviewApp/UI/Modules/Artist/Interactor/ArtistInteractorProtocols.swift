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
    
    func getTrackUri(for index: Int)
    func getTrackURL(for index: Int)
    func getTrackAlbumId(for index: Int)
}

protocol ArtistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchArtistInfo(_ artistInfo: (Artist?, [Track], [Album]))
    func interactorFailedToFetchArtistInfo()
    
    func interactorDidGetArtistStatus(_ status: ArtistStatus)
    func interactorDidGetPlaylist(tracks: [Track], for index: Int)
    
    func interactorDidFollowOnArtist()
    func interactorFailedToFollowOnArtist(_ error: String)
    func interactorUnfollowArtist()
    func interactorFailedToUnfollowArtist(_ error: String)
    
    func interactorDidGetAlbumId(_ identifier: String)
    
    func interactorDidGetTrackUri(_ uri: String)
    func interactorDidGetTrackURL(_ url: String)
    func interactorDidGetTrackAlbumId(_ albumId: String)
}
