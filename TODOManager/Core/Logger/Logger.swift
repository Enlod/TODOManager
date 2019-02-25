//
//  Logger.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/2/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

enum LoggerPriority {
    case debug
    case info
    case error
    
    var prefix: String {
        let prefix: String
        
        switch self {
        case .debug:
            prefix = "DEBUG"
        case .info:
            prefix = "INFO"
        case .error:
            prefix = "ERROR"
        }
        
        return prefix
    }
}

protocol Logger {
    func log(_ priority: LoggerPriority, _ message: String)
}
