//
//  TableViewReusableCellProvider.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/22/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

struct TableViewReusableCellProvider {
    private let tableView: UITableView
    private let indexPath: IndexPath
    
    init(tableView: UITableView, indexPath: IndexPath) {
        self.tableView = tableView
        self.indexPath = indexPath
    }
    
    func reusableCell<Cell: UITableViewCell>() -> Cell {
        return tableView.dequeueReusableCell(indexPath: indexPath)
    }
    
    func updateHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
