//
//  KeychainService.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation
import KeychainSwift

final class KeychainService {
    private let keychain = KeychainSwift()
}

extension KeychainService: KeychainServiceProtocol {
    func remove(key: String) {
        keychain.delete(key)
    }
    
    func set<T: Codable>(_ data: T, key: String) {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(data) else {
            return
        }
        
        keychain.set(data, forKey: key)
    }
    
    func get<T: Codable>(key: String) -> T? {
        let decoder = JSONDecoder()
        
        guard let tokenData = keychain.getData(key), let token = try? decoder.decode(T.self, from: tokenData) else {
            return nil
        }
        
        return token
    }
}
