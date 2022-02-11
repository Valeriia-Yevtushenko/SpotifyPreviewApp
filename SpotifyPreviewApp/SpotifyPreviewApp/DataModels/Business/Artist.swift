//
//  Artist.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let identifier, name: String?
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case identifier = "id"
        case name
    }
}
