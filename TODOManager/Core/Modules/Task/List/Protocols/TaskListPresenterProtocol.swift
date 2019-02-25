//
//  TaskListPresenterProtocol.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/17/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol TaskListPresenterProtocol: PresenterProtocol {
    var interactor: TaskListInteractorProtocol { get }
    var router: TaskListRouterProtocol { get }
    var viewProvider: () -> TaskListViewProtocol? { get }
    
    func requestTaskList()
    
    func select(_ task: Task)
    func makeTask()
    func delete(_ task: Task)
}
