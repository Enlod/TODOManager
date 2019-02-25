//
//  PersistableTransactionMock.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift

class PersistableTransactionMock: PersistableTransaction {
    let onBegin = PublishSubject<Void>()
    let onUpdate = PublishSubject<Void>()
    let onDelete = PublishSubject<Void>()
    let onCommit = PublishSubject<Void>()
    let onRollback = PublishSubject<Void>()
    
    override func begin() {
        onBegin.onNext(())
    }
    
    override func update<Element: Persistable>(_ objects: [Element]) {
        onUpdate.onNext(())
    }
    
    override func delete<Element: Persistable>(_ objects: [Element]) {
        onDelete.onNext(())
    }
    
    override func commit() throws {
        onCommit.onNext(())
    }
    
    override func rollback() {
        onRollback.onNext(())
    }
}
