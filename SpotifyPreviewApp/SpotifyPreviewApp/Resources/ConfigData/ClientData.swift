//
//  RequestData.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

enum Authorization: String {
    case scope = "user-follow-read+user-read-private+user-read-email+user-top-read"
    // swiftlint:disable all
    case codeVerifier = "ToCFHo51D5P-hNOOcJif6iGygUVvEa7VIGsYAnPQ.kjYO7PDCQlQNqb.HtP7KovxciXzyr4Nt62thWx4bl10pX1_-R.uDg8B0FTzy22WlO1gT4cIlnJ1q5V4i1h1~.We"
    // swiftlint:enable all
    case codeChallenge = "KJWod-tKNY82_U9phkQYgcZ4okDUj3pRrk8hGari6-4"
    case state = "e21392da45dbf4"
    case code = "code"
}

enum Client: String {
    case identifier = "b3d154a34d9748b1b0028fa3ad1e9931"
    case secret = "4fe70c1969e84552aef7653f454d1ad7"
}

enum Request: String {
    case allCategories = "https://api.spotify.com/v1/browse/categories?limit=30"
    case authURL = "https://accounts.spotify.com/authorize"
    case accessToken = "https://accounts.spotify.com/api/token"
}
