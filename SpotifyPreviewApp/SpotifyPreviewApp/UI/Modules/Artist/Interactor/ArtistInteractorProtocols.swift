//
//  ArtistInteractorProtocols.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 02.06.2021.
//

import Foundation

protocol ArtistInteractorInputProtocol: AnyObject {
    func fetchArtistInfo()
}

protocol ArtistInteractorOutputProtocol: AnyObject {
    func interactorDidFetchArtistInfo(_ artistInfo: (Artist?, [Track], [Album]))
    func interactorFailedToFetchArtistInfo()
}
