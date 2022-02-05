//
//  NetworkServiceProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 01.02.2022.
//

import Foundation
import PromiseKit

protocol NetworkServiceProtocol {
    func fetch<T: Codable>(_ url: String) -> Promise<T>
    func post<T: Codable>(data: Data, url: String) -> Promise<T> 
}
