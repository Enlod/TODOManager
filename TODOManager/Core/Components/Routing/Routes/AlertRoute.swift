//
//  AlertRoute.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/2/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol AlertRoute {
    func navigateToAlert(with configurator: AlertConfigurator)
}

struct AlertConfigurator {
    var title: String?
    var message: String?
    var actions = [UIAlertAction]()
}
