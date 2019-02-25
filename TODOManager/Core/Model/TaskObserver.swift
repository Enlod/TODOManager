//
//  TaskObserver.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/19/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxCocoa

struct TaskObserver {
    let id: BehaviorRelay<String?>
    let name: BehaviorRelay<String?>
    let date: BehaviorRelay<Date?>
    let details: BehaviorRelay<String?>
    
    var task: Task {
        return Task(
            id: id.value,
            name: name.value,
            date: date.value,
            details: details.value
        )
    }
    
    init(task: Task) {
        id = BehaviorRelay(value: task.id)
        name = BehaviorRelay(value: task.name)
        date = BehaviorRelay(value: task.date)
        details = BehaviorRelay(value: task.details)
    }
}
