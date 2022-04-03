//
//  TrackContextMenuAction.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 03.04.2022.
//

import UIKit.UIImage

enum TrackContextMenuAction: String {
    case share = "Share"
    case download = "Download"
    case addToPlaylist = "Add to playlist"
    case artist = "Show track's artist"
    case album = "Show track's album"
    case delete = "Delete track from playlist"
    
    var image: UIImage? {
        switch self {
        case .share:
            return UIImage(systemName: "square.and.arrow.up")
        case .download:
            return UIImage(systemName: "square.and.arrow.down")
        case .addToPlaylist:
            return UIImage(systemName: "folder.badge.plus.fill")
        case .artist:
            return UIImage(systemName: "person")
        case .album:
            return UIImage(systemName: "folder")
        case .delete:
            return UIImage(systemName: "trash")
        }
    }
}
