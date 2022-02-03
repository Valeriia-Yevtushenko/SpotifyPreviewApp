//
//  User.swift
//  SpotifyPreviewApp
//
//  Created by Yevtushenko Valeriia on 02.02.2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let country, displayName, email: String?
    let explicitContent: ExplicitContent?
    let externalUrls: UserExternalUrls?
    let followers: UserFollowers?
    let href: String?
    let identifier: String?
    let images: [UserImage]?
    let product, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers, href
        case identifier = "id"
        case images, product, type, uri
    }
}

// MARK: - ExplicitContent
struct ExplicitContent: Codable {
    let filterEnabled, filterLocked: Bool?

    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}

// MARK: - ExternalUrls
struct UserExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Followers
struct UserFollowers: Codable {
    let href: JSONNull?
    let total: Int?
}

// MARK: - Image
struct UserImage: Codable {
    let height: JSONNull?
    let url: String?
    let width: JSONNull?
}
