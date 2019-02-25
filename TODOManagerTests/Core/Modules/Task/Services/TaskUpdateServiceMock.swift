//
//  TaskUpdateServiceMock.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskUpdateServiceMock: TaskUpdateServiceProtocol {
    var validator: TaskValidationServiceProtocol = TaskValidationServiceMock()
    
    let onUpdate = PublishSubject<Void>()
    
    func update(_ task: Task, in transaction: PersistableTransaction) throws {
        onUpdate.onNext(())
    }
}
