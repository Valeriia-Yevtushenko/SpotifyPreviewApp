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
    func post(data: Data, url: String) -> Promise<Void>
    func post<T: Codable>(data: Data, url: String) -> Promise<T>
    func put(data: Data, url: String) -> Promise<Void>
    func put(data: Data, header: [String: String], url: String) -> Promise<Void>
    func delete(url: String) -> Promise<Void>
    func delete(data: Data, url: String) -> Promise<Void> 
}
