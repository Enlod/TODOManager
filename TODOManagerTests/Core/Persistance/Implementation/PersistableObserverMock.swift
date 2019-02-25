//
//  PersistableObserverMock.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift

class PersistableObserverMock<Element: Persistable>: PersistableObserver<Element> {
    var elements = [Element]()
    
    override var count: Int {
        return elements.count
    }
    
    override func filtered(_ predicate: NSPredicate) -> Self {
        return self
    }
    
    override func sorted(by desctiptor: PersistableSortDescriptor) -> Self {
        return self
    }
    
    override subscript(index: Int) -> Element {
        return elements[index]
    }
    
    override func objects() -> [Element] {
        return elements
    }
    
    override func observe() -> Observable<PersistableChangeset<Element>> {
        return Observable.never()
    }
}
