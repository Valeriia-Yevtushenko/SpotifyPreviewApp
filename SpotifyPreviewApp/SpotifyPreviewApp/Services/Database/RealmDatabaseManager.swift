//
//  RealmDatabase.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 05.04.2022.
//

import Foundation
import RealmSwift

class RealmDatabaseService {
    private var container = try? Realm()
}

extension RealmDatabaseService {
    typealias DataModel = Object
    
    func fetch<T: Object>() -> [T]? {
        return container?.objects(T.self).reversed()
    }
    
    func fetch<T: Object>(filter: NSPredicate) -> [T]? {
        return container?.objects(T.self).filter(filter).reversed()
    }
    
    func save(_ object: Object) {
        try? self.container?.write({
            self.container?.add(object)
        })
    }
    
    func delete(_ object: Object) {
        try? self.container?.write({
            self.container?.delete(object)
        })
    }
}
