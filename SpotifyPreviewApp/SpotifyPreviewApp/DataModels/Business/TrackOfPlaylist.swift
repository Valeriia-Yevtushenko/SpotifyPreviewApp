//
//  TrackOfPlaylist.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

// MARK: - TracksOfPlaylist
struct TracksOfPlaylist: Codable {
    let items: [ItemOfPlaylist]?
}

// MARK: - Item
struct ItemOfPlaylist: Codable {
    let addedBy: AddedBy?
    let track: Track?

    enum CodingKeys: String, CodingKey {
        case addedBy = "added_by"
        case track
    }
}

// MARK: - AddedBy
struct AddedBy: Codable {
    let identifier, name: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}

// MARK: - Track
struct Track: Codable {
    let album: TrackAlbum?
    let artists: [AddedBy]?
    let href: String?
    let identifier, name: String?
    
    enum CodingKeys: String, CodingKey {
        case album, href, artists
        case identifier = "id"
        case name
    }
}

// MARK: - Album
struct TrackAlbum: Codable {
    let href: String?
    let images: [AlbumImage]?
    let name: String?
}

// MARK: - Image
struct AlbumImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}
