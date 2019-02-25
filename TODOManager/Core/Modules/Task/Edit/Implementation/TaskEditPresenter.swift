//
//  TaskEditPresenter.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/18/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskEditPresenter: TaskEditPresenterProtocol {
    var interactor: TaskEditInteractorProtocol
    var router: TaskEditRouterProtocol
    var viewProvider: () -> TaskEditViewProtocol?
    
    func requestTask() {
        viewProvider()?.show(interactor.task)
    }
    
    func cancelEdit() {
        router.close()
    }
    
    func doneEdit(_ task: Task) {
        interactor
            .update(task)
            .subscribe(showErrorFrom: router, onCompleted: router.close)
            .dispose()
    }
}
