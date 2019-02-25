//
//  TaskListInteractorTests.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class TaskListInteractorTests: TestCase {
    func testDelete() {
        var deleteCount = 0
        
        let taskDeleteService = TaskDeleteServiceMock()
        taskDeleteService.onDelete
            .subscribe(onNext: { deleteCount += 1 })
            .disposed(by: self)
        
        let transaction = PersistableTransactionMock()
        
        let persistableProvider = PersistableProviderMock()
        persistableProvider.definedTransaction = transaction
        
        let taskListInteractor = TaskListInteractor(
            taskDeleteService: taskDeleteService,
            persistableProvider: persistableProvider
        )
        
        let tester = TransactionTester(transaction: transaction)
        tester.execute {
            taskListInteractor
                .delete(Task())
                .subscribe()
                .disposed(by: self)
        }
        
        XCTAssertEqual(deleteCount, 1)
    }
}
