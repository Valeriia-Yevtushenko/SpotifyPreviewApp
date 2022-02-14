//
//  Album.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

// MARK: - Album
struct Albums: Codable {
    let items: [Album]
}

// MARK: - Album
struct Album: Codable {
    let identifier: String
    let images: [Image]?
    let name: String?
    let externalUrls: ExternalUrls
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case identifier = "id"
        case images, name
    }
}
