//
//  LazyPropertyTests.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 8/25/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class LazyPropertyTests: TestCase {
    func testValue() {
        let value = "value"
        
        let lazyProperty = LazyProperty<String> {
            return value
        }
        
        XCTAssertEqual(lazyProperty.value, value)
    }
    
    func testInitializedOnce() {
        var initializationCount = 0
        
        let lazyProperty = LazyProperty<Int> {
            initializationCount += 1
            
            return 0
        }
        
        _ = lazyProperty.value
        _ = lazyProperty.value
        _ = lazyProperty.value
        
        XCTAssertEqual(initializationCount, 1)
    }
    
    func testCachedValue() {
        let value = 0
        
        let lazyProperty = LazyProperty<Int> {
            return value
        }
        
        XCTAssertNil(lazyProperty.cachedValue)
        XCTAssertEqual(lazyProperty.value, value)
        XCTAssertNotNil(lazyProperty.cachedValue)
    }
    
    func testCachedValueDoesNotInvokeInitializer() {
        var initializationCount = 0
        
        let lazyProperty = LazyProperty<Int> {
            initializationCount += 1
            
            return 0
        }
        
        _ = lazyProperty.cachedValue
        _ = lazyProperty.cachedValue
        
        XCTAssertEqual(initializationCount, 0)
    }
    
    func testReset() {
        var value = 0
        
        let lazyProperty = LazyProperty<Int> {
            return value
        }
        
        lazyProperty.reset()
        value += 1
        
        XCTAssertEqual(lazyProperty.value, value)
        
        lazyProperty.reset()
        value += 1
        
        XCTAssertEqual(lazyProperty.value, value)
    }
    
    func testOptional() {
        var value: Int? = nil
        var initializationCount = 0
        
        let lazyProperty = LazyProperty<Int?> {
            initializationCount += 1
            
            return value
        }

        XCTAssertNil(lazyProperty.value)
        
        _ = lazyProperty.value
        _ = lazyProperty.value
        
        value = 0
        lazyProperty.reset()
        XCTAssertEqual(lazyProperty.value, value)
        
        XCTAssertEqual(initializationCount, 2)
    }
}
