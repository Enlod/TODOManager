//
//  TaskEditPresenterTests.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class TaskEditPresenterTests: TestCase {
    func test() {
        var onShowTask = 0
        var onUpdate = 0
        var onClose = 0
        
        let interactor = TaskEditInteractorMock()
        interactor.onUpdate
            .subscribe(onNext: { onUpdate += 1 })
            .disposed(by: self)
        
        let router = RouterMock()
        router.closeNavigation
            .subscribe(onNext: { onClose += 1 })
            .disposed(by: self)
        
        let view = TaskEditViewMock()
        view.onShow
            .subscribe(onNext: { onShowTask += 1 })
            .disposed(by: self)
        
        let taskEditPresenter = TaskEditPresenter(interactor: interactor, router: router, viewProvider: { view })
        
        taskEditPresenter.requestTask()
        XCTAssertEqual(onShowTask, 1)
        
        taskEditPresenter.cancelEdit()
        XCTAssertEqual(onUpdate, 0)
        XCTAssertEqual(onClose, 1)
        
        taskEditPresenter.doneEdit(Task ())
        XCTAssertEqual(onUpdate, 1)
        XCTAssertEqual(onClose, 2)
    }
}
