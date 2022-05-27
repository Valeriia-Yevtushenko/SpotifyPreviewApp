//
//  ListOfArtists.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 11.02.2022.
//

import Foundation

// MARK: - ListOfArtists
struct ListOfArtists: Codable {
    let artists: Artists
}

// MARK: - Artists
struct Artists: Codable {
    let items: [Artist]
}
