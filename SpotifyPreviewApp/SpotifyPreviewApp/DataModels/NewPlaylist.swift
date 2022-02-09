//
//  NewPlaylist.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 04.02.2022.
//

import Foundation

struct NewPlaylist: Codable {
    var name: String
    var description: String
    var isPublic: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case isPublic = "public"
    }
}
