//
//  PersistableTransaction.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation

class PersistableTransaction {
    func begin() {
        fatalError()
    }
    
    func update<Element: Persistable>(_ objects: [Element]) {
        fatalError()
    }
    
    func delete<Element: Persistable>(_ objects: [Element]) {
        fatalError()
    }
    
    func commit() throws {
        fatalError()
    }
    
    func rollback() {
        fatalError()
    }
}

extension PersistableTransaction {
    func update<Element: Persistable>(_ object: Element) {
        update([object])
    }
    
    func delete<Element: Persistable>(_ object: Element) {
        delete([object])
    }
    
    func execute(_ closure: () throws -> Void) rethrows -> Void {
        do {
            try closure()
        }
        catch {
            rollback()
            
            throw error
        }
    }
}
