//
//  TableViewCellGroupController.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

final class TableViewCellGroupController {
    private(set) var rows = LazyProperty { 0 }
    let configurator: TableViewCellIndexConfigurator
    private(set) lazy var updates = PublishSubject<ListChanges>()
    
    var hidden = false {
        didSet {
            guard hidden != oldValue else {
                return
            }
            
            let changes: ListChanges
            if hidden {
                changes = ListChanges(deletions: Array(0..<rows.value))
            }
            else {
                rows.reset()
                changes = ListChanges(insertions: Array(0..<rows.value))
            }
            
            updates.onNext(changes)
        }
    }
    
    init(rows: @escaping () -> Int = { 1 },
         configurator: TableViewCellIndexConfigurator) {
        self.configurator = configurator
        
        self.rows = LazyProperty({ [unowned self] in
            return self.hidden ? 0 : rows()
        })
    }
    
    func reload() {
        updates.onNext(ListChanges(modifications: [0]))
    }
}

//MARK: - PersistableObserver

extension TableViewCellGroupController {
    struct ObservableCreator<Element: Persistable> {
        func from(
            observer: PersistableObserver<Element>,
            configurator: TableViewCellPersistableConfigurator<Element>,
            disposableHandler: @escaping (_ disposable: Disposable) -> Void)
            -> TableViewCellGroupController {
                let onSelect = configurator.onSelect.map { onSelect in
                    return { (index: Int, deselect: () -> Void) in
                        onSelect(observer[index], deselect)
                    }
                }
                
                let actions = configurator.actions.map { actions in
                    return { (index: Int) in
                        return actions(observer[index])
                    }
                }
                
                let group = TableViewCellGroupController(
                    rows: { observer.count },
                    configurator: TableViewCellIndexConfigurator(
                        dequeueCell: { cellProvider, index in
                            return configurator.dequeueCell(cellProvider, observer[index])
                    },
                        onSelect: onSelect,
                        actions: actions
                    )
                )
                
                let disposable = observer
                    .observe()
                    .subscribe(onNext: { [unowned group] changeset in
                        switch changeset {
                        case .initial(observer: _):
                            break
                            
                        case .update(observer: _, listChanges: let listChanges):
                            group.updates.onNext(listChanges)
                            
                            break
                        }
                    })
                disposableHandler(disposable)
                
                return group
        }
    }
}
