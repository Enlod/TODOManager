//
//  PersistableAssemblerMock.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

extension PersistableAssembler {
    func resolve() -> PersistableProvider {
        return PersistableProviderMock()
    }
}
