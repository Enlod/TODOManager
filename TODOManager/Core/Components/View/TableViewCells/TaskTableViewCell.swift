//
//  TaskTableViewCell.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

class TaskTableViewCell: TableViewCell {
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
    }
    
    override func makeLayout() {
        super.makeLayout()
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.configureDefault()
        nameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0 * 2.0),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8.0 * 2.0),
            local {
                let constraint = nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0)
                constraint.priority -= 1
                
                return constraint
            }
        ])
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.configureAccent()
        dateLabel.font = dateLabel.font.withSize(UIFont.smallSystemFontSize)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0 * 2.0)
        ])
    }
}
