//
//  RequestData.swift
//  SpotifyPreviewApp
//
//  Created by Valeria Yevtushenko on 16.01.2022.
//

import Foundation

enum Path: String {
    case user = "me"
    case categories = "browse/categories"
    case category = "browse/categories/%@/playlists"
    
    case search
    
    case playlist = "playlists/%@"
    case userPlaylist = "me/playlists"
    case playlistFollowers = "playlists/%@/followers"
    case playlistImage = "playlists/%@/images"
    
    case following = "me/following"
    case isFolowing = "me/following/contains"
    case artist = "artists/%@"
    case artistTopTrack = "artists/%@/top-tracks"
    case artistAlbums = "artists/%@/albums"
    
    case album = "albums/%@"
}
