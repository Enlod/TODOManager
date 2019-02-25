//
//  ValidationServiceMock.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation

struct TaskValidationServiceMock: TaskValidationServiceProtocol {
    var errorToThrow: Error?
    
    func validate(_ task: Task) throws {
        try errorToThrow.map { throw $0 }
    }
}
