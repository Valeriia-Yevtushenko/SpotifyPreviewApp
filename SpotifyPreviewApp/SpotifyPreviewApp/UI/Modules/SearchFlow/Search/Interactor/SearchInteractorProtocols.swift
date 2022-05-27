//
//  SearchInteractorProtocol.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation

protocol SearchInteractorInputProtocol: AnyObject {
    func getTrack(at index: Int)
    func fetchSearchText(_ text: String)
    
    func saveTrack(at index: Int)
    func getTrackUri(at index: Int)
    func getTrackURL(at index: Int)
    func getTrackArtistId(at index: Int)
    func getTrackAlbumId(at index: Int)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func interactorDidFetchData(_ data: ListOfSearchedTracks)
    func interactorDidGetTrack(tracks: [Track])
    func interactorFailedToFetchData()
    
    func interactorDidGetTrackUri(_ uri: String)
    func interactorDidGetTrackURL(_ url: String)
    func interactorDidGetTrackArtistId(_ artistId: String)
    func interactorDidGetTrackAlbumId(_ albumId: String)
}
