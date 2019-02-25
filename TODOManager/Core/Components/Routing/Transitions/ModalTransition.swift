//
//  ModalTransition.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class ModalTransition: NSObject, AnimatedTransition {
    var animator: Animator? = nil
    var animated = true
    var completion: (() -> Void)?
    
    var viewController: UIViewController?
    
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle
    
    init(modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
         modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

//MARK: - Transition

extension ModalTransition: Transition {
    @objc func open(_ viewController: UIViewController) {
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        
        if animator != nil {
            viewController.transitioningDelegate = self
        }
        
        self.viewController?.present(viewController, animated: animated, completion: completion)
    }
    
    func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: animated, completion: completion)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ModalTransition: UIViewControllerTransitioningDelegate {
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        
        return animator
    }
}
