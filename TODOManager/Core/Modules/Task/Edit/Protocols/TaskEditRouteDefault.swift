//
//  TaskEditRouteDefault.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

extension TaskEditRoute where Self: RouterProtocol {
    func navigateToEdit(task: Task) {
        let assembler = TaskEditAssembler()
        let transition = assembler.resolveTransition()
        let viewController = assembler.resolveViewController(openedTransition: transition, task: task)
        
        open(viewController, transition: transition)
    }
}
