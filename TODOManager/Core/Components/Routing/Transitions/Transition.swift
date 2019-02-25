//
//  Transition.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol Transition: class {
    var viewController: UIViewController? { get set }
    var completion: (() -> Void)? { get set }
    
    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}

protocol AnimatedTransition: Transition {
    var animator: Animator? { get set }
    var animated: Bool { get set }
}
