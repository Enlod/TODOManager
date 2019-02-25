//
//  TaskUpdateService.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/18/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol TaskUpdateServiceProtocol {
    var validator: TaskValidationServiceProtocol { get }
    func update(_ task: Task, in transaction: PersistableTransaction) throws
}

struct TaskUpdateService: TaskUpdateServiceProtocol{
    let validator: TaskValidationServiceProtocol
    
    func update(_ task: Task, in transaction: PersistableTransaction) throws {
        try transaction.execute {
            try validator.validate(task)
            transaction.update(task)
        }
    }
}
