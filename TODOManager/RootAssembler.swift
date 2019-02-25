//
//  RootAssembler.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class RootAssembler {
    func resolveWindow() -> UIWindow {
        let rootViewController = NavigationController(rootViewController: TaskListAssembler().resolveTaskList())
        rootViewController.navigationBar.configureDefault()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        return window
    }
}
