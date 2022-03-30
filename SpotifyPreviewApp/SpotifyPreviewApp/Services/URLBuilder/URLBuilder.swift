//
//  URLBuilder.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 15.02.2022.
//

import Foundation

class URLBuilder {
    private var version = "/v1/"
    private var path: String = ""
    private var queryItems: [String: String]?
}

extension URLBuilder: URLBuilderProtocol {
    func with(path: Path) -> URLBuilderProtocol {
        self.queryItems = nil
        self.path = path.rawValue
        return self
    }
    
    func with(pathParameter: String) -> URLBuilderProtocol {
        self.path = String(format: path, pathParameter)
        return self
    }

    func with(queryItems: [String: String]) -> URLBuilderProtocol {
        self.queryItems = queryItems
        return self
    }
    
    func build() -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.spotify.com"
        urlComponents.path = version + path
        urlComponents.queryItems = queryItems?.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        return urlComponents.url?.absoluteString ?? ""
    }
}
