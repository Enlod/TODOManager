//
//  RealmPersistableProvider.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/20/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RealmPersistableProvider: PersistableProvider {
    override func observer<Element: Persistable>(type: Element.Type) -> Observable<PersistableObserver<Element>>
        where Element.ManagedObject: Object {
            return connection()
                .map { return $0.objects(type.ManagedObject.self) }
                .map(RealmPersistableObserver.init(results:))
    }
    
    override func transaction() -> Observable<PersistableTransaction> {
        return connection()
            .map(RealmPersistableTransaction.init(realm:))
    }
    
    private func connection() -> Observable<Realm> {
        return Observable.create { observable in
            do {
                let realm = try Realm()
                observable.onNext(realm)
                observable.onCompleted()
            }
            catch {
                observable.onError(error)
            }
            
            return Disposables.create()
        }
            .do(onError: { self.log(.error, $0.localizedDescription) })
    }
}

extension Results {
    func toArray() -> [Element] {
        return Array(self)
    }
}
