//
//  LazyProperty.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class LazyProperty<Element> {
    private let initializer: () -> Element
    private(set) var cachedValue: Element?
    
    init(_ initializer: @escaping () -> Element) {
        self.initializer = initializer
    }
    
    var value: Element {
        return cachedValue ?? local {
            let value = initializer()
            cachedValue = value
            
            return value
        }
    }
    
    func reset() {
        cachedValue = nil
    }
}
