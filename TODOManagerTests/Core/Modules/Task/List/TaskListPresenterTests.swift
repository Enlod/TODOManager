//
//  TaskListPresenterTests.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class TaskListPresenterTests: TestCase {
    func testRouter() {
        var alertNavigationCount = 0
        var taskeEditNavigationCount = 0
        
        let router = RouterMock()
        
        router.alertNavigation
            .subscribe(onNext: { alertNavigationCount += 1 })
            .disposed(by: self)
        
        router.editNavigation
            .subscribe(onNext: { taskeEditNavigationCount += 1 })
            .disposed(by: self)
        
        let taskListPresenter = TaskListPresenter(
            interactor: TaskListInteractorMock(),
            router: router,
            viewProvider: {
                return TaskListViewMock()
            }
        )
        
        taskListPresenter.requestTaskList()
        
        let task = Task()
        taskListPresenter.select(task)
        XCTAssertEqual(taskeEditNavigationCount, 1)
        XCTAssertEqual(alertNavigationCount, 0)
        
        taskListPresenter.makeTask()
        XCTAssertEqual(taskeEditNavigationCount, 2)
        XCTAssertEqual(alertNavigationCount, 0)
        
        taskListPresenter.delete(task)
        XCTAssertEqual(taskeEditNavigationCount, 2)
        XCTAssertEqual(alertNavigationCount, 1)
    }
    
    func testNotEmptyTaskList() {
        let observer = PersistableObserverMock<Task>()
        observer.elements = [Task()]
        
        executeTest(with: observer) { (onTaskListGroupConfiguratorRequest, onShowTaskList, onShowTaskListError) in
            XCTAssertEqual(onTaskListGroupConfiguratorRequest, 1)
            XCTAssertEqual(onShowTaskList, 1)
            XCTAssertEqual(onShowTaskListError, 0)
        }
    }
    
    func testEmptyTaskList() {
        let observer = PersistableObserverMock<Task>()
        observer.elements = []
        
        executeTest(with: observer) { (onTaskListGroupConfiguratorRequest, onShowTaskList, onShowTaskListError) in
            XCTAssertEqual(onTaskListGroupConfiguratorRequest, 1)
            XCTAssertEqual(onShowTaskList, 1)
            XCTAssertEqual(onShowTaskListError, 0)
        }
    }
    
    private func executeTest(with observer: PersistableObserver<Task>, resultHandler: (_ onTaskListGroupConfiguratorRequest: Int, _ onShowTaskList: Int, _ onShowTaskListError: Int) -> Void) {
        var onTaskListGroupConfiguratorRequest = 0
        var onShowTaskList = 0
        var onShowTaskListError = 0
        
        let observer = PersistableObserverMock<Task>()
        observer.elements = [Task()]
        
        let persistableProvider = PersistableProviderMock()
        persistableProvider.definedObserver = observer
        
        var taskListInteractor = TaskListInteractorMock()
        taskListInteractor.persistableProvider = persistableProvider
        
        let taskListView = TaskListViewMock()
        
        taskListView.onTaskListGroupConfiguratorRequest
            .subscribe(onNext: { onTaskListGroupConfiguratorRequest += 1 })
            .disposed(by: self)
        
        taskListView.onShowTaskList
            .subscribe(onNext: { onShowTaskList += 1 })
            .disposed(by: self)
        
        taskListView.onShowTaskListError
            .subscribe(onNext: { onShowTaskListError += 1 })
            .disposed(by: self)
        
        let taskListPresenter = TaskListPresenter(
            interactor: taskListInteractor,
            router: RouterMock(),
            viewProvider: {
                return taskListView
            }
        )
        
        let task = Task()
        
        taskListPresenter.requestTaskList()
        
        taskListPresenter.select(task)
        taskListPresenter.makeTask()
        taskListPresenter.delete(task)
        
        resultHandler(onTaskListGroupConfiguratorRequest, onShowTaskList, onShowTaskListError)
    }
}

extension PersistableObserver where Element == Task {
    func sortedByDate(ascending: Bool = true) -> Self {
        return self
    }
}
