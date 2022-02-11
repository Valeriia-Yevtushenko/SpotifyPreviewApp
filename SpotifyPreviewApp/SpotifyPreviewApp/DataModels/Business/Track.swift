//
//  Track.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

// MARK: - Track
struct Track: Codable {
    let album: Album?
    let artists: [Artist]?
    let identifier, name: String?
    let externalUrls: ExternalUrls
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case album, artists
        case identifier = "id"
        case name
    }
}
