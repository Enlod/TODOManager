//
//  RealmPersistable.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/20/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    static func generateID() -> String {
        return UUID().uuidString
    }
}
