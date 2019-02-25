//
//  UIViewExtensions.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
