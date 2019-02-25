//
//  TaskEditInteractor.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/18/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskEditInteractor: TaskEditInteractorProtocol {
    var task: Task
    
    var updateService: TaskUpdateServiceProtocol
    var persistableProvider: PersistableProvider
    
    func update(_ task: Task) -> Observable<Void> {
        return persistableProvider
            .transaction()
            .do(onNext: { $0.begin() })
            .do(onNext: { transaction in
                try self.updateService.update(task, in: transaction)
            })
            .map { try $0.commit() }
    }
}
