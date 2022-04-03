//
//  TrackOfPlaylist.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation

// MARK: - Playlist
struct Playlist: Codable {
    let externalUrls: ExternalUrls
    let description: String?
    let identifier: String
    let images: [Image]?
    let name: String?
    let owner: Owner?
    let tracks: TracksOfPlaylist?
    let type, uri: String?
    let isPublic: Bool?
    let snapshotID: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case description
        case identifier = "id"
        case images, name, owner
        case tracks, type, uri
        case snapshotID = "snapshot_id"
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
