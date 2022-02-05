//
//  User.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 02.02.2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let country, displayName, email: String?
    let identifier: String?
    let images: [Image]?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case identifier = "id"
        case images, uri
    }
}
