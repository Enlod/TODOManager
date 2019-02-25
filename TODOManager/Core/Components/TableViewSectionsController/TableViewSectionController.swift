//
//  TableViewSectionController.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class TableViewSectionController: DisposeBagHolder {
    var disposeBag = DisposeBag()
    private let cellGroups: [TableViewCellGroupController]
    private var groupPositions = [CountableRange<Int>]()
    
    let name: String
    private(set) var updates = PublishSubject<ListChanges>()
    
    init(name: String, cellGroups: [TableViewCellGroupController]) {
        self.name = name
        self.cellGroups = cellGroups
    }
    
    lazy var rows: Int = {
        var groupIndex = 0
        
        return cellGroups.reduce(0) { total, group in
            group.updates.subscribe(onNext: { [groupIndex, unowned self] listChanges in
                var groupPositions = self.groupPositions
                let groupRows = groupPositions[groupIndex]
                let groupStartIndex = groupRows.lowerBound
                let groupSize = groupRows.upperBound - groupStartIndex
                let groupSizeChangeDelta = (listChanges.insertions.count - listChanges.deletions.count)
                
                self.rows += groupSizeChangeDelta
                groupPositions[groupIndex] = (groupStartIndex..<groupStartIndex + groupSize + groupSizeChangeDelta)
                
                (groupIndex + 1..<groupPositions.count).forEach { nextGroupIndex in
                    var nextGroupRows = groupPositions[nextGroupIndex]
                    nextGroupRows = (nextGroupRows.lowerBound + groupSizeChangeDelta..<nextGroupRows.upperBound + groupSizeChangeDelta)
                    groupPositions[nextGroupIndex] = nextGroupRows
                }
                
                self.groupPositions = groupPositions
                
                self.updates.onNext(listChanges.modified(with: groupStartIndex))
            })
                .disposed(by: self)
            
            let result = total + group.rows.value
            groupPositions.append(total..<result)
            groupIndex += 1
            
            return result
        }
    }()
    
    func cellGroupInfo(at row: Int) -> GroupInfo {
        let groupIndex = groupPositions.index { $0.contains(row) }!
        
        return GroupInfo(
            group: cellGroups[groupIndex],
            subIndex: groupPositions[groupIndex].startIndex + row
        )
    }
}

//MARK: - GroupInfo

extension TableViewSectionController {
    struct GroupInfo {
        let group: TableViewCellGroupController
        let subIndex: Int
    }
}
