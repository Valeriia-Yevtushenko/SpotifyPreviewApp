//
//  RequestData.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

final class URLBuilder {
    private var baseUrl = "https://api.spotify.com/v1/"
}

enum Request: String {
    case allCategories = "https://api.spotify.com/v1/browse/categories?limit=50"
    case authURL = "https://accounts.spotify.com/authorize"
    case accessToken = "https://accounts.spotify.com/api/token"
    case playlists = "https://api.spotify.com/v1/browse/categories/"
    case search = "https://api.spotify.com/v1/search?"
    case callbackUrl = "SpotifyPreviewApp://oauth-callback"
    case playlist = "https://api.spotify.com/v1/playlists/"
    case deletePlaylist
    case addPlaylist
    case updatePlaylist
    case playlistImage
    case user = "https://api.spotify.com/v1/me"
    case userPlaylists = "https://api.spotify.com/v1/me/playlists"
    case userFollows = "https://api.spotify.com/v1/me/following?type=artist"
    case artist = "https://api.spotify.com/v1/artists/"
    case artistTopTrack
    case artistAlbums
    case isUserFollowsArtist = "https://api.spotify.com/v1/me/following/contains?type=artist&ids="
    case followOnArtist

    func createUrl(data: String) -> String {
        switch self {
        case .playlist:
        return rawValue + data
        case .playlists:
            return rawValue + data + "/playlists?limit=50"
        case .search:
            return rawValue + "q=\(data)&type=track&limit=50"
        case .playlistImage:
            return "https://api.spotify.com/v1/playlists/" + data + "/images"
        case .artist:
            return rawValue + data
        case .artistTopTrack:
            return "https://api.spotify.com/v1/artists/" + data + "/top-tracks?market=us"
        case .artistAlbums:
            return "https://api.spotify.com/v1/artists/" + data + "/albums?limit=5"
        case .deletePlaylist:
            return "https://api.spotify.com/v1/playlists/\(data)/followers"
        case .addPlaylist:
            return "https://api.spotify.com/v1/playlists/\(data)/followers"
        case .updatePlaylist:
            return "https://api.spotify.com/v1/playlists/\(data)"
        case .isUserFollowsArtist:
            return rawValue + data
        case .followOnArtist:
            return "https://api.spotify.com/v1/me/following?type=artist&ids=" + data
        default:
            return ""
        }
    }
}
