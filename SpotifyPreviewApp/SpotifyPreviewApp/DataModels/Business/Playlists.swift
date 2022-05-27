//
//  Playlists.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 21.05.2021.
//

import Foundation

// MARK: - ListOfPlaylists
struct ListOfPlaylists: Codable {
    let playlists: Playlists?
}

// MARK: - Playlists
struct Playlists: Codable {
    let items: [Playlist]?
}
