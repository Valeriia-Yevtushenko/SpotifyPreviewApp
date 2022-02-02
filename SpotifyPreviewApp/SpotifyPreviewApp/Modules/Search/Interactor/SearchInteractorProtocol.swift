//
//  SearchInteractorProtocol.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation

protocol SearchInteractorInputProtocol: AnyObject {
    func fetchSearchData(_ text: String)
}

protocol SearchInteractorOutputProtocol {
    func interactorDidFetchData(_ data: ListOfTrack)
    func interactorFailedToFetchData()
}
