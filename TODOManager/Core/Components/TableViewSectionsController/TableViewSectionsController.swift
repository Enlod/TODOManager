//
//  TableViewSectionsController.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class TableViewSectionsController: NSObject, DisposeBagHolder {
    struct Animation {
        var insert = UITableView.RowAnimation.automatic
        var reload = UITableView.RowAnimation.automatic
        var delete = UITableView.RowAnimation.automatic
    }
    
    let disposeBag = DisposeBag()
    private var sections: [TableViewSectionController]
    
    var rowAnimation = Animation()
    var sectionAnimation = Animation(insert: .fade, reload: .fade, delete: .fade)
    
    weak var tableView: UITableView? {
        didSet {
            guard let tableView = tableView else {
                return
            }
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    init(sections: [TableViewSectionController]) {
        self.sections = sections
        
        super.init()
        
        var sectionIndex = 0
        
        sections.forEach { section in
            var hidden = section.rows == 0
            
            section.updates
                .subscribe(onNext: { [sectionIndex, unowned section, unowned self] listChanges in
                    guard let tableView = self.tableView else {
                        return
                    }
                    
                    guard section.rows > 0 else {
                        tableView.deleteSections([sectionIndex], with: self.sectionAnimation.delete)
                        hidden = true
                        
                        return
                    }
                    
                    guard !hidden else {
                        tableView.insertSections([sectionIndex], with: self.sectionAnimation.insert)
                        hidden = false
                        
                        return
                    }
                    
                    tableView.performBatchUpdates({
                        let rowsMapper = { row in
                            return IndexPath(row: row, section: sectionIndex)
                        }
                        tableView.insertRows(
                            at: listChanges.insertions.map(rowsMapper),
                            with: self.rowAnimation.insert
                        )
                        tableView.reloadRows(
                            at: listChanges.modifications.map(rowsMapper),
                            with: self.rowAnimation.reload
                        )
                        tableView.deleteRows(
                            at: listChanges.deletions.map(rowsMapper),
                            with: self.rowAnimation.delete
                        )
                    }, completion: nil)
                })
                .disposed(by: self)
            
            sectionIndex += 1
        }
    }
    
    private var visibleSection: [TableViewSectionController] {
        return sections.filter { $0.rows > 0 }
    }
    
    private func groupInfo(at indexPath: IndexPath) -> TableViewSectionController.GroupInfo {
        return visibleSection[indexPath.section].cellGroupInfo(at: indexPath.row)
    }
}

//MARK: - UITableViewDataSource

extension TableViewSectionsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return visibleSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleSection[section].rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupInfo = self.groupInfo(at: indexPath)
        let group = groupInfo.group
        let cell = group.configurator.dequeueCell(TableViewReusableCellProvider(tableView: tableView, indexPath: indexPath), groupInfo.subIndex)
        cell.selectionStyle = group.configurator.onSelect == nil ? .none : .default
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return visibleSection[section].name
    }
}

//MARK: - UITableViewDelegate

extension TableViewSectionsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupInfo = self.groupInfo(at: indexPath)
        groupInfo.group.configurator.onSelect?(groupInfo.subIndex, { [unowned tableView] in
            tableView.deselectRow(at: indexPath, animated: true)
        })
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let groupInfo = self.groupInfo(at: indexPath)
        
        return groupInfo.group.configurator.actions?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return groupInfo(at: indexPath).group.configurator.actions != nil
    }
}
