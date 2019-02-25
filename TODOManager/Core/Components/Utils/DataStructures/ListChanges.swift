//
//  ListChanges.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/30/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

struct ListChanges {
    let insertions: [Int]
    let modifications: [Int]
    let deletions: [Int]
    
    init(insertions: [Int] = [], modifications: [Int] = [], deletions: [Int] = []) {
        self.insertions = insertions
        self.modifications = modifications
        self.deletions = deletions
    }
    
    func modified(with value: Int) -> ListChanges {
        let modifier = { (changes: [Int]) in
            return changes.map { $0 + value }
        }
        
        return ListChanges(
            insertions: modifier(insertions),
            modifications: modifier(modifications),
            deletions: modifier(deletions)
        )
    }
}
