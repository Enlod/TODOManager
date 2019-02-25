//
//  Functions.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

func local<ReturnType>(_ closure: () -> ReturnType) -> ReturnType {
    return closure()
}
