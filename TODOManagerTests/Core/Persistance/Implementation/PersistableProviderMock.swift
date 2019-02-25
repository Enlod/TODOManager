//
//  PersistableProviderMock.swift
//  TemplateProjectTests
//
//  Created by Roman Voskovskyi on 9/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift

class PersistableProviderMock: PersistableProvider {
    var definedObserver: Any? = nil
    var definedTransaction: PersistableTransactionMock? = nil
    
    override func observer<Element: Persistable>(type: Element.Type) -> Observable<PersistableObserver<Element>> {
        return Observable.just((definedObserver as? PersistableObserverMock<Element>) ?? PersistableObserverMock<Element>())
    }
    
    override func transaction() -> Observable<PersistableTransaction> {
        return Observable.just(definedTransaction ?? PersistableTransactionMock())
    }
}
