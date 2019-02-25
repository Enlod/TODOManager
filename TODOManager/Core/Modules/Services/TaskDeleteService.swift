//
//  TaskDeleteService.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol TaskDeleteServiceProtocol {
    func delete(_ task: Task, in transaction: PersistableTransaction)
}

struct TaskDeleteService: TaskDeleteServiceProtocol {
    func delete(_ task: Task, in transaction: PersistableTransaction) {
        transaction.delete(task)
    }
}
