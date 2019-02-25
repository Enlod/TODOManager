//
//  FunctionsTests.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class FunctionsTests: TestCase {
    func testLocal() {
        var invocationCount = 0
        let returnValue = 7
        
        XCTAssertEqual(local {
            invocationCount += 1
            
            return returnValue
        }, returnValue)
        
        XCTAssert(invocationCount == 1)
    }
}
