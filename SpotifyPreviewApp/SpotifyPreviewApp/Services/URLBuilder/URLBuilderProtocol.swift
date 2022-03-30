//
//  URLBuilderProtocol.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 15.02.2022.
//

import Foundation

protocol URLBuilderProtocol: AnyObject {
    func with(path: Path) -> URLBuilderProtocol
    func with(pathParameter: String) -> URLBuilderProtocol
    func with(queryItems: [String: String]) -> URLBuilderProtocol
    func build() -> String
}
