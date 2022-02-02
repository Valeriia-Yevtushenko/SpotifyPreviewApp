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
    let href: String?
    let items: [PlaylistItem]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: JSONNull?
    let total: Int?
}

// MARK: - Item
struct PlaylistItem: Codable {
    let collaborative: Bool?
    let itemDescription: String?
    let externalUrls: PlaylistExternalUrls?
    let href: String?
    let identifier: String?
    let images: [PlaylistImage]?
    let name: String?
    let owner: PlaylistOwner?
    let primaryColor, itemPublic: JSONNull?
    let snapshotID: String?
    let tracks: Tracks?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case collaborative
        case itemDescription = "description"
        case externalUrls = "external_urls"
        case href
        case identifier = "id"
        case images, name, owner
        case primaryColor = "primary_color"
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - ExternalUrls
struct PlaylistExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Image
struct PlaylistImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

// MARK: - Owner
struct PlaylistOwner: Codable {
    let displayName: String?
    let externalUrls: SongExternalUrls?
    let href: String?
    let identifier, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href
        case identifier = "id"
        case type, uri
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String?
    let total: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self,
                                             DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
