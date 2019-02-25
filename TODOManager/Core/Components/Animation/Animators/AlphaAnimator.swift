//
//  AlphaAnimator.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

struct AlphaAnimator: AnimatorProtocol {
    var hidden: Bool
    
    func animate(_ view: UIView, in context: AnimationContext, completion: @escaping (_ finished: Bool) -> Void) {
        context.add(animation: {
            view.alpha = self.hidden ? 0.0 : 1.0
        }, completion: { _ in })
    }
}
