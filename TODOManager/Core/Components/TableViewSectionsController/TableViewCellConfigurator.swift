//
//  TableViewCellConfigurator.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class TableViewCellPersistableConfigurator<Element: Persistable>: TableViewCellConfigurator<Element> {}
class TableViewCellIndexConfigurator: TableViewCellConfigurator<Int> {}

class TableViewCellConfigurator<Element> {
    typealias DequeueCell = (_ cellProvider: TableViewReusableCellProvider, _ element: Element) -> UITableViewCell
    typealias OnSelect = ((_ element: Element, _ deselect: () -> Void) -> Void)?
    typealias Actions = ((_ element: Element) -> [UITableViewRowAction]?)?
    
    let dequeueCell: DequeueCell
    let onSelect: OnSelect
    let actions: Actions
    
    init(dequeueCell: @escaping DequeueCell,
         onSelect: OnSelect = nil,
         actions: Actions = nil) {
        self.dequeueCell = dequeueCell
        self.onSelect = onSelect
        self.actions = actions
    }
}
