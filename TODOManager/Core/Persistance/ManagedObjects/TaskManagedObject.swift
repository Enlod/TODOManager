//
//  TaskManagedObject.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/11/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RealmSwift

extension Task: Persistable {
    init(managedObject: TaskManagedObject) {
        id = managedObject.id
        name = managedObject.name
        details = managedObject.details
        date = managedObject.date
    }
    
    func toManagedObject() -> TaskManagedObject {
        let managedObject = TaskManagedObject()
        managedObject.id = (id ?? generateID())
        managedObject.name = name
        managedObject.details = details
        managedObject.date = date
        
        return managedObject
    }
}

class TaskManagedObject: Object {
    @objc dynamic var id: String?
    
    @objc dynamic var name: String?
    @objc dynamic var details: String?
    @objc dynamic var date: Date?
    
    override class func primaryKey() -> String? {
        return #keyPath(TaskManagedObject.id)
    }
}

extension PersistableObserver where Element == Task {
    func sortedByDate(ascending: Bool = true) -> Self {
        return sorted(by:
            PersistableSortDescriptor(
                key: #keyPath(TaskManagedObject.date),
                ascending: ascending
            )
        )
    }
}
