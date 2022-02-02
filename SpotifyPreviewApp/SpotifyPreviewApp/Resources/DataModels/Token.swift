//
//  Token.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

struct Token: Codable {
    var access: String
    var refresh: String
    var date: Date?
}
