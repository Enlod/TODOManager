//
//  RealmPersistableObserver.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/20/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RealmPersistableObserver<Element: Persistable>: PersistableObserver<Element>
    where Element.ManagedObject: Object {
    private let results: Results<Element.ManagedObject>
    
    init(results: Results<Element.ManagedObject>) {
        self.results = results
    }
    
    override func sorted(by desctiptor: PersistableSortDescriptor) -> RealmPersistableObserver<Element> {
        return RealmPersistableObserver(results: results.sorted(byKeyPath: desctiptor.key, ascending: desctiptor.ascending))
    }
    
    override func filtered(_ predicate: NSPredicate) -> RealmPersistableObserver<Element> {
        return RealmPersistableObserver(results: results.filter(predicate))
    }
    
    override var count: Int {
        return results.count
    }
    
    override subscript(index: Int) -> Element {
        return Element(managedObject: results[index])
    }
    
    override func objects() -> [Element] {
        return results.toArray().map(Element.init(managedObject:))
    }
    
    override func observe() -> Observable<PersistableChangeset<Element>> {
        return Observable.create { observable in
            let notificationToken = self.results.observe { change in
                switch change {
                case .initial(_):
                    observable.onNext(.initial(observer: self))
                    
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    observable.onNext(.update(observer: self, listChanges: ListChanges(
                        insertions: insertions,
                        modifications: modifications,
                        deletions: deletions)))
                    
                case .error(let error):
                    observable.onError(error)
                }
            }
            
            return Disposables.create {
                notificationToken.invalidate()
            }
        }
    }
}
