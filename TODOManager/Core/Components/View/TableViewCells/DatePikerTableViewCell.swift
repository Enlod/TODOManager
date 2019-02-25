//
//  DatePikerTableViewCell.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/4/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class DatePikerTableViewCell: TableViewCell {
    private lazy var zeroHeightConstraint: NSLayoutConstraint = {
        let constraint = contentView.heightAnchor.constraint(equalToConstant: 0.0)
        constraint.priority -= 1.0
        
        return constraint
    }()
    
    let datePicker = UIDatePicker()
    
    var expanded = true {
        didSet {
            guard expanded != oldValue else {
                return
            }
            
            updateExpandedState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        expanded = true
    }
    
    override func makeLayout() {
        super.makeLayout()
        
        contentView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            datePicker.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            datePicker.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        updateExpandedState()
    }
    
    private func updateExpandedState() {
        zeroHeightConstraint.isActive = !expanded
    }
}
