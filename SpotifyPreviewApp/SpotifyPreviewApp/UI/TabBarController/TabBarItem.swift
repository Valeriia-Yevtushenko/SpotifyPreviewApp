//
//  TabBarItem.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 31.01.2022.
//

import Foundation

enum TabBarItem: String {
    case search = "Search"
    case profile = "Profile"
    
    var imageName: String {
        switch self {
        case .search:
            return "magnifyingglass.circle"
        case .profile:
            return "person.crop.circle"
        }
    }
    
    var tag: Int {
        switch self {
        case .search:
            return 0
        case .profile:
            return 1
        }
    }
}
