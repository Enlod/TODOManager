//
//  TaskListViewMock.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class TaskListViewMock: TaskListViewProtocol {
    let onTaskListGroupConfiguratorRequest = PublishSubject<Void>()
    let onShowTaskList = PublishSubject<Void>()
    let onShowTaskListError = PublishSubject<Void>()
    let onShowEmptyTaskList = PublishSubject<Bool>()
    
    func taskListGroupConfigurator() -> TableViewCellPersistableConfigurator<Task> {
        onTaskListGroupConfiguratorRequest.onNext(())
        
        return TableViewCellPersistableConfigurator(dequeueCell: { _, _ in
            return TableViewCell()
        })
    }
    
    func show(_ taskListGroup: TableViewCellGroupController) {
        onShowTaskList.onNext(())
    }
    
    func showTaskList(error: Error) {
        onShowTaskListError.onNext(())
    }
    
    func showTaskList(empty: Bool, context: AnimationContext) {
        onShowEmptyTaskList.onNext(empty)
    }
}
