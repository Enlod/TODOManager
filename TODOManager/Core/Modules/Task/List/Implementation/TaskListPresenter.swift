//
//  TaskListPresenter.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/17/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

struct TaskListPresenter: TaskListPresenterProtocol, DisposeBagHolder {
    let disposeBag = DisposeBag()
    
    let interactor: TaskListInteractorProtocol
    let router: TaskListRouterProtocol
    var viewProvider: () -> TaskListViewProtocol?
    
    func requestTaskList() {
        guard let view = viewProvider() else {
            return
        }
        
        interactor.persistableProvider
            .observer(type: Task.self)
            .map { $0.sortedByDate(ascending: false) }
            .do(onNext: { observer in
                observer
                    .observe()
                    .subscribe(onNext: { _ in
                        let context = self.resolveContext()
                        view.showTaskList(
                            empty: observer.count == 0,
                            context: context
                        )
                        context.execute(animated: true)
                    })
                    .disposed(by: self)
            })
            .map { observer in
                TableViewCellGroupController.ObservableCreator<Task>().from(
                    observer: observer,
                    configurator: view.taskListGroupConfigurator(),
                    disposableHandler: { $0.disposed(by: self) }
                )
            }
            .subscribe(
                onNext: { taskListGroup in
                    view.show(taskListGroup)
                },
                onError: { error in
                    view.showTaskList(error: error)
                }
            )
            .disposed(by: self)
    }
    
    func select(_ task: Task) {
        router.navigateToEdit(task: task)
    }
    
    func makeTask() {
        router.navigateToEdit(task: Task())
    }
    
    func delete(_ task: Task) {
        var configurator = AlertConfigurator()
        configurator.title = "Delete task \"\(task.name ?? "")\"?"
        configurator.actions = [UIAlertAction(
            title: "OK",
            style: .destructive,
            handler: { _ in
                self.interactor
                    .delete(task)
                    .subscribe()
                    .dispose()
        }), UIAlertAction(title: "Cancel", style: .default, handler: nil)]
        
        router.navigateToAlert(with: configurator)
    }
}
