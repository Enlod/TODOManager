//
//  TaskListInteractor.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/17/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskListInteractor: TaskListInteractorProtocol {
    var taskDeleteService: TaskDeleteServiceProtocol
    var persistableProvider: PersistableProvider
    
    func delete(_ task: Task) -> Observable<Void> {
        return persistableProvider
            .transaction()
            .do(onNext: { $0.begin() })
            .do(onNext: { self.taskDeleteService.delete(task, in: $0) })
            .map { try $0.commit() }
    }
}
