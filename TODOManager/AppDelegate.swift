//
//  AppDelegate.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 1/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = RootAssembler().resolveWindow()
        
        return true
    }
}
