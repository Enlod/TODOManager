//
//  RxSwiftExtensions.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/31/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Observable {
    func subscribe(showErrorFrom router: AlertRoute, onCompleted: (() -> Void)?) -> Disposable {
        return subscribe(onError: { error in
            var configuration = AlertConfigurator()
            configuration.title = error.localizedDescription
            configuration.actions = [UIAlertAction(title: "OK", style: .default, handler: nil)]
            
            router.navigateToAlert(with: configuration)
        }, onCompleted: onCompleted)
    }
}

infix operator <->
func <-> <Element>(property: ControlProperty<Element>, variable: BehaviorRelay<Element>) -> Disposable {
    var updating = false
    
    let bindToControlDisposable = variable
        .asObservable()
        .filter { _ in
            updating.toggle()
            
            return updating
        }
        .bind(to: property)
    
    let bindToVariableDisposable = property
        .filter { _ in
            updating.toggle()
            
            return updating
        }
        .subscribe(
            onNext: variable.accept,
            onCompleted: bindToControlDisposable.dispose
        )
    
    return CompositeDisposable(disposables: [bindToControlDisposable, bindToVariableDisposable])
}
