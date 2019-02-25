//
//  TaskUpdateServiceTests.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest
import RxSwift

enum ErrorMock: Error {
    case case1
    case case2
}

class TaskUpdateServiceTests: TestCase {
    func testThowValidatorError() {
        let expectedError = ErrorMock.case1
        
        var validator = TaskValidationServiceMock()
        validator.errorToThrow = expectedError
        
        let taskUpdateService = TaskUpdateService(validator: validator)
        
        XCTAssertThrowsError(try taskUpdateService.update(Task(), in: PersistableTransactionMock())) { error in
            XCTAssertEqual(error as? ErrorMock, expectedError)
        }
    }
    
    func testTransactionInvoke() {
        var updateInvokeCount = 0
        
        let transaction = PersistableTransactionMock()
        transaction.onUpdate
            .subscribe(onNext: { updateInvokeCount += 1 })
            .disposed(by: self)
        
        let taskUpdateService = TaskUpdateService(validator: TaskValidationServiceMock())
        XCTAssertNoThrow(try taskUpdateService.update(Task(), in: transaction))
        
        XCTAssertEqual(updateInvokeCount, 1)
    }
}
