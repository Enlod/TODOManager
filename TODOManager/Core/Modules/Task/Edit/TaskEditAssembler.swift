//
//  TaskEditAssembler.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/25/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class TaskEditAssembler: PersistableAssembler {
    func resolveViewController(openedTransition: Transition, task: Task) -> UIViewController {
        let router = TaskEditRouter()
        router.openedTransition = openedTransition
        
        let interactor = TaskEditInteractor(
            task: task,
            updateService: TaskUpdateService(validator: TaskValidationService()),
            persistableProvider: resolve()
        )
        
        var viewProtocol: TaskEditViewProtocol?
        
        let presenter = TaskEditPresenter(interactor: interactor, router: router, viewProvider: { viewProtocol })
        
        let view = TaskEditViewController(presenter: presenter)
        router.sourceViewController = view
        viewProtocol = view
        
        return view
    }
    
    func resolveTransition() -> Transition {
        return PushTransition()
    }
}
