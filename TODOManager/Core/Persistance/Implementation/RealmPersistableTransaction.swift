//
//  RealmPersistableTransaction.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/20/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RealmPersistableTransaction: PersistableTransaction {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    override func begin() {
        realm.beginWrite()
    }
    
    override func update<Element: Persistable>(_ objects: [Element])
        where Element.ManagedObject: Object {
        realm.add(objects.map { $0.toManagedObject() }, update: true)
    }
    
    override func delete<Element: Persistable>(_ objects: [Element])
        where Element.ManagedObject: Object {
        objects
            .compactMap { $0.id }
            .forEach { id in
                _ = realm
                    .object(
                        ofType: Element.ManagedObject.self,
                        forPrimaryKey: id
                    )
                    .map(realm.delete)
        }
    }
    
    override func commit() throws {
        try realm.commitWrite()
    }
    
    override func rollback() {
        realm.cancelWrite()
    }
}
