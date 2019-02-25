//
//  LoggerDefault.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/25/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

extension Logger {
    func log(_ priority: LoggerPriority, _ message: String) {
        print(priority.prefix + ": " + message)
    }
}
