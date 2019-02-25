//
//  TableViewCell.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/30/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class TableViewCell: UITableViewCell {
    private(set) var reuseDisposableBag = LazyProperty({ DisposeBag() })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reuseDisposableBag.reset()
    }
    
    func makeLayout() {}
}
