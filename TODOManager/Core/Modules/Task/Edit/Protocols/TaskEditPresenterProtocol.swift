//
//  TaskEditPresenterProtocol.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/18/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol TaskEditPresenterProtocol: PresenterProtocol {
    var interactor: TaskEditInteractorProtocol { get }
    var router: TaskEditRouterProtocol { get }
    var viewProvider: () -> TaskEditViewProtocol? { get }
    
    func requestTask()
    
    func cancelEdit()
    func doneEdit(_ task: Task)
}
