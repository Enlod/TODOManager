//
//  TaskListInteractorProtocol.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/17/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

protocol TaskListInteractorProtocol {
    var taskDeleteService: TaskDeleteServiceProtocol { get }
    var persistableProvider: PersistableProvider { get }
    
    func delete(_ task: Task) -> Observable<Void>
}
