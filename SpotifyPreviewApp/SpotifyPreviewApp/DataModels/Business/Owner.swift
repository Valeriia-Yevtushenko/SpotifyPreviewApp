//
//  Owner.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

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
