//
//  AnimatorProtocol.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol AnimatorProtocol {
    func animate(_ view: UIView, in context: AnimationContext, completion: @escaping (_ finished: Bool) -> Void)
}
