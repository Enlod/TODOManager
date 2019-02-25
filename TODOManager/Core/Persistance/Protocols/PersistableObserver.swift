//
//  PersistableObserver.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/20/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift

enum PersistableChangeset<Element: Persistable> {
    case initial(observer: PersistableObserver<Element>)
    case update(observer: PersistableObserver<Element>, listChanges: ListChanges)
}

struct PersistableSortDescriptor {
    var key: String
    var ascending = true
}

class PersistableObserver<Element: Persistable> {
    var count: Int {
        fatalError()
    }
    
    func filtered(_ predicate: NSPredicate) -> Self {
        fatalError()
    }
    
    func sorted(by desctiptor: PersistableSortDescriptor) -> Self {
        fatalError()
    }
    
    subscript(index: Int) -> Element {
        fatalError()
    }
    
    func objects() -> [Element] {
        fatalError()
    }
    
    func observe() -> Observable<PersistableChangeset<Element>> {
        fatalError()
    }
}
