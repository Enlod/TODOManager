//
//  ConfigurableView.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol ConfigurableViewDefault: ColorsAssembler {
    func configureDefault()
}

protocol ConfigurableViewAccent: ConfigurableViewDefault {
    func configureAccent()
}

extension UILabel: ConfigurableViewAccent {
    func configureDefault() {
        textColor = text()
    }
    
    func configureAccent() {
        configureDefault()
        textColor = accent()
    }
}

extension UINavigationBar: ConfigurableViewDefault {
    func configureDefault() {
        barTintColor = primary()
        tintColor = icons()
    }
}

extension UIBarButtonItem: ConfigurableViewDefault {
    func configureDefault() {
        tintColor = icons()
    }
}

extension UITextField: ConfigurableViewDefault {
    func configureDefault() {
        textColor = text()
    }
}
