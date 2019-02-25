//
//  TaskValidationServiceTests.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class TaskValidationServiceTests: TestCase {
    private let taskValidationService = TaskValidationService()
    
    func testNameNil() {
        XCTAssertThrowsError(try taskValidationService.validate(Task())) { error in
            XCTAssertEqual(error as? TaskValidationService.InvalidTaskError, TaskValidationService.InvalidTaskError.missingName)
        }
    }
    
    func testNameEmpty() {
        var task = Task()
        task.name = ""
        
        XCTAssertThrowsError(try taskValidationService.validate(task)) { error in
            XCTAssertEqual(error as? TaskValidationService.InvalidTaskError, TaskValidationService.InvalidTaskError.missingName)
        }
    }
    
    func testDateNil() {
        var task = Task()
        task.name = "xD"
        
        XCTAssertThrowsError(try taskValidationService.validate(task)) { error in
            XCTAssertEqual(error as? TaskValidationService.InvalidTaskError, TaskValidationService.InvalidTaskError.missingDate)
        }
    }
    
    func testFilled() {
        var task = Task()
        task.name = "xD"
        task.date = Date()
        
        XCTAssertNoThrow(try taskValidationService.validate(task))
    }
}
