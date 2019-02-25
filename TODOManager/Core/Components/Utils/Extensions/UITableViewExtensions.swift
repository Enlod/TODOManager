//
//  UITableViewExtensions.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell>(indexPath: IndexPath) -> Cell {
        let reuseIdentifier = Cell.reuseIdentifier        
        register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
        
        return dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
    }
}
