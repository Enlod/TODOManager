//
//  PushTransition.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/27/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class PushTransition: NSObject {
    var viewController: UIViewController?
    var completion: (() -> Void)?
    
    var animated = true
    var animator: Animator?
}

extension PushTransition: AnimatedTransition {
    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: animated)
    }
}

// MARK: - UINavigationControllerDelegate

extension PushTransition: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        completion?()
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator.map { animator in
            animator.isPresenting = (operation == .push)
            
            return animator
        }
    }
}
