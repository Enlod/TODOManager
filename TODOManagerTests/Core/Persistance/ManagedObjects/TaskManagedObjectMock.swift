//
//  TaskManagedObjectMock.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

extension Task: Persistable {
    init(managedObject: ManagedObjectMock) {}
    
    func toManagedObject() -> ManagedObjectMock {
        return ManagedObjectMock()
    }
}
