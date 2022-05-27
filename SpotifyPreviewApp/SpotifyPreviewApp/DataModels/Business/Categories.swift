//
//  Model.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 18.05.2021.
//

import Foundation
// MARK: - Categories
struct ListOfCategories: Codable {
    let categories: Categories
}

// MARK: - CategoriesArray
struct Categories: Codable {
    let items: [Category]
}

// MARK: - Item
struct Category: Codable {
    let icons: [Image]
    let identifier, name: String
    
    enum CodingKeys: String, CodingKey {
        case icons
        case identifier = "id"
        case name
    }
}
