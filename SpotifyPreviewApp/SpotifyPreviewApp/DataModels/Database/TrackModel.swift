//
//  TrackModel.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 04.04.2022.
//

import Foundation
import RealmSwift

class TrackModel: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var artists: String = ""
    @objc dynamic var extetnalUrl: String = ""
    @objc dynamic var uri: String = ""
    @objc dynamic var albumId: String = ""
    @objc dynamic var artistId: String = ""
    @objc dynamic var image: Data?
    @objc dynamic var data: Data?
}
