//
//  TaskEditInteractorTests.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest
import RxSwift

class TaskEditInteractorTests: TestCase {
    func testUpdate() {
        var onUpdateCount = 0
        
        let taskUpdateService = TaskUpdateServiceMock()
        taskUpdateService
            .onUpdate
            .subscribe(onNext: { onUpdateCount += 1 })
            .disposed(by: self)
        
        let transaction = PersistableTransactionMock()
        let peristableProvider = PersistableProviderMock()
        peristableProvider.definedTransaction = transaction
        
        let taskEditInteractor = TaskEditInteractor(
            task: Task(),
            updateService: taskUpdateService,
            persistableProvider: peristableProvider
        )
        
        let tester = TransactionTester(transaction: transaction)
        tester.execute {
            taskEditInteractor
                .update(Task())
                .subscribe()
                .disposed(by: self)
        }
        
        XCTAssertEqual(onUpdateCount, 1)
    }
}
