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
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func interactorDidFetchData(_ data: ListOfSearchedTracks)
    func interactorDidGetTrack(tracks: Track)
    func interactorFailedToFetchData()
}
