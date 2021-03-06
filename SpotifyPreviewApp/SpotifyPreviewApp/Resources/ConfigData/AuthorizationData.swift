//
//  ServicesData.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

enum Authorization: String {
    case url = "https://accounts.spotify.com/authorize"
    case callbackUrl = "SpotifyPreviewApp://oauth-callback"
    case accessToken = "https://accounts.spotify.com/api/token"
    // swiftlint:disable all
    case scope = "user-follow-read+user-read-private+playlist-read-private+user-read-email+playlist-modify-public+playlist-modify-private+ugc-image-upload+user-follow-modify"
    case codeVerifier = "ToCFHo51D5P-hNOOcJif6iGygUVvEa7VIGsYAnPQ.kjYO7PDCQlQNqb.HtP7KovxciXzyr4Nt62thWx4bl10pX1_-R.uDg8B0FTzy22WlO1gT4cIlnJ1q5V4i1h1~.We"
    // swiftlint:enable all
    case codeChallenge = "KJWod-tKNY82_U9phkQYgcZ4okDUj3pRrk8hGari6-4"
    case state = "e21392da45dbf4"
    case code = "code"
}
