//
//  Persistable.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/20/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import Foundation

protocol Persistable {
    var id: String? { get set }
    
    associatedtype ManagedObject
    
    init(managedObject: ManagedObject)
    func toManagedObject() -> ManagedObject
    
    func generateID() -> String
}

extension Persistable {
    func generateID() -> String {
        return UUID().uuidString
    }
}
