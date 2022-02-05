//
//  ServicesData.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

enum Service: String {
    case oauth = "OAuth2Swift"
    case keychainService = "KeychainService"
    case authorization = "AuthorizationService"
}

enum Authorization: String {
    case scope = "user-follow-read+user-read-private+playlist-read-private+user-read-email+playlist-modify-public+playlist-modify-private"
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
