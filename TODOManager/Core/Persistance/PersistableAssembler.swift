//
//  PersistableAssembler.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/21/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation

protocol PersistableAssembler {
    func resolve() -> PersistableProvider
}
