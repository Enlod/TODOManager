//
//  PersistableProvider.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/20/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RxSwift

class PersistableProvider: Logger {
    func observer<Element: Persistable>(type: Element.Type) -> Observable<PersistableObserver<Element>> {
        fatalError()
    }
    
    func transaction() -> Observable<PersistableTransaction> {
        fatalError()
    }
}
