//
//  Model.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation
// MARK: - Categories
struct Categories: Codable {
    let categories: CategoriesArray
}

// MARK: - CategoriesArray
struct CategoriesArray: Codable {
    let href: String
    let items: [Category]
    let limit: Int
    let next: String
    let offset: Int
    let previous: JSONNull?
    let total: Int
}

// MARK: - Item
struct Category: Codable {
    let href: String
    let icons: [Icon]
    let identifier, name: String
    
    enum CodingKeys: String, CodingKey {
        case href, icons
        case identifier = "id"
        case name
    }
}

// MARK: - Icon
struct Icon: Codable {
    let height: Int?
    let url: String
    let width: Int?
}
