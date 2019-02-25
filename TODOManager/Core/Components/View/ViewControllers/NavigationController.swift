//
//  NavigationController.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return childForStatusBarHidden
    }
}
