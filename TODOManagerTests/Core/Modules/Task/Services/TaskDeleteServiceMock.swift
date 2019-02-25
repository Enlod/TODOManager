//
//  TaskDeleteServiceMock.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskDeleteServiceMock: TaskDeleteServiceProtocol {
    let onDelete = PublishSubject<Void>()
    
    func delete(_ task: Task, in transaction: PersistableTransaction) {
        onDelete.onNext(())
    }
}
