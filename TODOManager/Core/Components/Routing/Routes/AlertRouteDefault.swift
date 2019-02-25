//
//  AlertRouteDefault.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/24/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

extension AlertRoute where Self: RouterProtocol {
    func navigateToAlert(with configurator: AlertConfigurator) {
        let alert = UIAlertController(title: configurator.title, message: configurator.message, preferredStyle: .alert)
        
        configurator.actions.forEach { action in
            alert.addAction(action)
        }
        
        open(alert, transition: ModalTransition())
    }
}
