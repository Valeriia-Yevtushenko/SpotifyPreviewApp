//
//  KeychainServiceProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

protocol KeychainServiceProtocol {
    func set<T: Codable>(_ data: T, key: String)
    func remove(key: String)
    func get<T: Codable>(key: String) -> T?
}
