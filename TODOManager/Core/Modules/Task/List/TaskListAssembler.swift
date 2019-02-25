//
//  TaskListAssembler.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/25/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class TaskListAssembler: PersistableAssembler {
    func resolveTaskList() -> UIViewController {
        let interactor = TaskListInteractor(
            taskDeleteService: TaskDeleteService(),
            persistableProvider: resolve()
        )
        let router = TaskListRouter()
        
        var viewProtocol: TaskListViewProtocol?
        
        let presenter = TaskListPresenter(interactor: interactor, router: router, viewProvider: { viewProtocol })
        let view = TaskListViewController(presenter: presenter)
        router.sourceViewController = view
        
        viewProtocol = view
        
        return view
    }
}
