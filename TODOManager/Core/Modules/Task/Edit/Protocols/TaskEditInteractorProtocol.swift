//
//  TaskEditInteractorProtocol.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/18/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

protocol TaskEditInteractorProtocol {
    var task: Task { get }
    
    var updateService: TaskUpdateServiceProtocol { get }
    var persistableProvider: PersistableProvider { get }
    
    func update(_ task: Task) -> Observable<Void>
}
