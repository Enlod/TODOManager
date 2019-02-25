//
//  TaskDeleteServiceTests.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class TaskDeleteServiceTests: TestCase {
    private let taskDeleteService = TaskDeleteService()
    
    func testDelete() {
        var deleteInvokeCount = 0
        
        let transaction = PersistableTransactionMock()
        transaction.onDelete
            .subscribe(onNext: { deleteInvokeCount += 1 })
            .disposed(by: self)
        taskDeleteService.delete(Task(), in: transaction)
        
        XCTAssertEqual(deleteInvokeCount, 1)
    }
}
