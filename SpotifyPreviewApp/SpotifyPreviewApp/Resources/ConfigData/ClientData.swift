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
    case playlists = "https://api.spotify.com/v1/browse/categories/"
    case search = "https://api.spotify.com/v1/search?"
    case callbackUrl = "SpotifyPreviewApp://oauth-callback"
    case playlist = "https://api.spotify.com/v1/playlists/"
    case playlistImage
    case user = "https://api.spotify.com/v1/me"
    case userPlaylists = "https://api.spotify.com/v1/me/playlists"
    case userFollows = "https://api.spotify.com/v1/me/following?type=artist&after=0I2XqVXqHScXjHhk6AYYRe"
    case artist = "https://api.spotify.com/v1/artists/"
    case artistTopTrack
    case artistAlbums
    
    func createUrl(data: String) -> String {
        switch self {
        case .playlist:
        return self.rawValue + data + "/tracks?limit=50"
        case .playlists:
            return self.rawValue + data + "/playlists?limit=30"
        case .search:
            return self.rawValue + "q=\(data)&type=track&limit=50"
        case .playlistImage:
            return "https://api.spotify.com/v1/playlists/" + data + "/images"
        case .artist:
            return self.rawValue + data
        case .artistTopTrack:
            return "https://api.spotify.com/v1/artists/" + data + "/top-tracks?market=ua"
        case .artistAlbums:
            return "https://api.spotify.com/v1/artists/" + data + "/albums?market=UA"
        default:
            return ""
        }
    }
}
