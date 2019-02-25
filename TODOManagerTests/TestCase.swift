//
//  TestCase.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest
import RxSwift

class TestCase: XCTestCase, DisposeBagHolder, PersistableAssembler {
    var disposeBag = DisposeBag()
}
