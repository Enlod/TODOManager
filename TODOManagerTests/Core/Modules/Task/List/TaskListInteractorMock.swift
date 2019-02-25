//
//  TaskListInteractorMock.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskListInteractorMock: TaskListInteractorProtocol {
    var taskDeleteService: TaskDeleteServiceProtocol = TaskDeleteServiceMock()
    var persistableProvider: PersistableProvider = PersistableProviderMock()
    
    let onDelete = PublishSubject<Void>()
    
    func delete(_ task: Task) -> Observable<Void> {
        onDelete.onNext(())
        
        return Observable.empty()
    }
}
