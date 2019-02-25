//
//  SlideAnimator.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

struct SlideAnimator: AnimatorProtocol {
    var hidden: Bool
    
    func animate(_ view: UIView, in context: AnimationContext, completion: @escaping (_ finished: Bool) -> Void) {
        guard let superview = view.superview else {
            return
        }
        
        let maxTranslateX = superview.frame.width / 2.0 + view.frame.width
        var transformX = hidden ? 0.0 : -maxTranslateX
        
        let animations = {
            var transform = view.transform
            transform.tx = transformX
            view.transform = transform
        }
        animations()
        
        transformX += maxTranslateX
        
        context.add(animation: animations, completion: completion)
    }
}
