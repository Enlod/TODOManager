//
//  TaskEditInteractorMock.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskEditInteractorMock: TaskEditInteractorProtocol {
    var task = Task()
    
    var updateService: TaskUpdateServiceProtocol = TaskUpdateServiceMock()
    var persistableProvider: PersistableProvider = PersistableProviderMock()
    
    let onUpdate = PublishSubject<Void>()
    let updateError: Error? = nil
    
    func update(_ task: Task) -> Observable<Void> {
        onUpdate.onNext(())
        
        return updateError.map(Observable.error) ?? Observable.empty()
    }
}
