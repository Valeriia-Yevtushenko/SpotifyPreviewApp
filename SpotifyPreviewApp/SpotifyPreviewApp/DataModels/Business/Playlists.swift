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

// MARK: - Image
struct Image: Codable {
    let url: String?
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String?
    let identifier, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case identifier = "id"
        case type, uri
    }
}
