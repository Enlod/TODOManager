//
//  Router.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol CloseRoute {
    func close()
}

protocol RouterProtocol: class {
    associatedtype ViewController: UIViewController
    var sourceViewController: ViewController? { get set }
    
    func open(_ viewController: UIViewController, transition: Transition)
}

class Router<ViewController>: RouterProtocol where ViewController: UIViewController {
    var openedTransition: Transition?
    weak var sourceViewController: ViewController?
    
    func open(_ viewController: UIViewController, transition: Transition) {
        assert(sourceViewController != nil, "Must provide a source view controller in order to perform open transition")
        
        transition.viewController = sourceViewController
        transition.open(viewController)
    }
    
    func close() {
        guard let openedTransition = openedTransition else {
            assertionFailure("Must provide an opened transition in order to perform close transition")
            return
        }
        
        guard let viewController = sourceViewController else {
            assertionFailure("Nothing to close")
            return
        }
        
        openedTransition.close(viewController)
    }
}
