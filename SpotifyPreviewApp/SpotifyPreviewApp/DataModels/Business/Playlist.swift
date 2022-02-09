//
//  TrackOfPlaylist.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

// MARK: - Playlist
struct Playlist: Codable {
    let description: String?
    let identifier: String
    let images: [Image]?
    let name: String?
    let owner: Owner?
    let tracks: TracksOfPlaylist
    let type, uri: String?
    let isPublic: Bool

    enum CodingKeys: String, CodingKey {
        case description
        case identifier = "id"
        case images, name, owner
        case tracks, type, uri
        case isPublic = "public"
    }
}

// MARK: - TracksOfPlaylist
struct TracksOfPlaylist: Codable {
    let items: [ItemOfPlaylist]?
}

// MARK: - Item
struct ItemOfPlaylist: Codable {
    let track: Track?
}

// MARK: - Track
struct Track: Codable {
    let album: TrackAlbum?
    let artists: [Artist]?
    let identifier, name: String?
    
    enum CodingKeys: String, CodingKey {
        case album, artists
        case identifier = "id"
        case name
    }
}

// MARK: - AddedBy
struct Artist: Codable {
    let identifier, name: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}

// MARK: - Album
struct TrackAlbum: Codable {
    let href: String?
    let images: [Image]?
    let name: String?
}
