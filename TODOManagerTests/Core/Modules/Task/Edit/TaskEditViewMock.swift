//
//  TaskEditViewMock.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class TaskEditViewMock: TaskEditViewProtocol {
    let onShow = PublishSubject<Void>()
    
    func show(_ task: Task) {
        onShow.onNext(())
    }
}
