//
//  TaskListViewProtocol.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/17/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

protocol TaskListViewProtocol: class {
    func taskListGroupConfigurator() -> TableViewCellPersistableConfigurator<Task>
    func show(_ taskListGroup: TableViewCellGroupController)
    func showTaskList(error: Error)
    func showTaskList(empty: Bool, context: AnimationContext)
}
