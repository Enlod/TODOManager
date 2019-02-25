//
//  UITableViewExtensionsTests.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 8/25/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest

class UITableViewExtensionsTests: TestCase {
    func testDequeueReusableCell() {
        let _: UITableViewCell = UITableView().dequeueReusableCell(indexPath: IndexPath(row: 0, section: 0))
    }
}
