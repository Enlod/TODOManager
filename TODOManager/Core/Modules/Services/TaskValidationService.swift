//
//  TaskValidationService.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/18/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol TaskValidationServiceProtocol {
    func validate(_ task: Task) throws
}

struct TaskValidationService: TaskValidationServiceProtocol {
    func validate(_ task: Task) throws {
        if task.name?.isEmpty ?? true {
            throw InvalidTaskError.missingName
        }
        
        if task.date == nil {
            throw InvalidTaskError.missingDate
        }
    }
    
    enum InvalidTaskError: Error {
        case missingName
        case missingDate
    }
}

extension TaskValidationService.InvalidTaskError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingName: return "Missing task name"
        case .missingDate: return "Missing task date"
        }
    }
}
