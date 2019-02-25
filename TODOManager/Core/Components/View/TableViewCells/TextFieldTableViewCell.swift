//
//  TextFieldTableViewCell.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/30/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class TextFieldTableViewCell: TableViewCell {
    let textField = UITextField()
    
    var maxInputLength: Int?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textField.placeholder = nil
        textField.text = nil
        maxInputLength = nil
    }
    
    override func makeLayout() {
        super.makeLayout()
        
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configureDefault()
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0 * 2.0),
            textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0 * 2.0),
            local {
                let constraint = textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0)
                constraint.priority -= 1
                
                return constraint
            }
        ])
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let maxInputLength = maxInputLength else {
            return true
        }
        
        return (textField.text?.count ?? 0) + (string.count - range.length) <= maxInputLength
    }
}
