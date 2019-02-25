//
//  RouterMock.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class RouterMock: TaskListRouterProtocol, TaskEditRouterProtocol {
    let editNavigation = PublishSubject<Void>()
    let alertNavigation = PublishSubject<Void>()
    let closeNavigation = PublishSubject<Void>()
    
    func navigateToEdit(task: Task) {
        editNavigation.onNext(())
    }
    
    func navigateToAlert(with configurator: AlertConfigurator) {
        alertNavigation.onNext(())
    }
    
    func close() {
        closeNavigation.onNext(())
    }
}
