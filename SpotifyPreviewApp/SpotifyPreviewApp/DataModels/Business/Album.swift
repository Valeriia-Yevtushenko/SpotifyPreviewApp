//
//  Album.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

// MARK: - Album
struct Album: Codable {
    let identifier: String
    let images: [Image]?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case images, name
    }
}
