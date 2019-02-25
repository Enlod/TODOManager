//
//  ColorsAssembler.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol ColorsAssembler {
    func primary() -> UIColor
    func accent() -> UIColor
    func text() -> UIColor
    func icons() -> UIColor
}

extension ColorsAssembler {
    func primary() -> UIColor {
        return UIColor(rgb: 0x607D8B)
    }
    
    func accent() -> UIColor {
        return UIColor(rgb: 0x536DFE)
    }
    
    func text() -> UIColor {
        return UIColor(rgb: 0x212121)
    }
    
    func icons() -> UIColor {
        return UIColor(rgb: 0xFFFFFF)
    }
}
