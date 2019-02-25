//
//  UIViewExtensionsTests.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 8/25/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class UIViewExtensionsTests: TestCase {
    func testReuseIdentifier() {
        XCTAssertEqual(UITableViewCell.reuseIdentifier, "UITableViewCell")
        XCTAssertEqual(TaskTableViewCell.reuseIdentifier, "TaskTableViewCell")
    }
}
