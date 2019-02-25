//
//  TitleWithValueTableViewCell.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 9/3/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class TitleWithValueTableViewCell: TableViewCell {
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    override func makeLayout() {
        super.makeLayout()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0 * 2),
            {
                let constraint = titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0)
                constraint.priority -= 1
                
                return constraint
            }(),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            valueLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8.0),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0 * 2)
        ])
        
        titleLabel.configureDefault()
        valueLabel.configureAccent()
    }
}
