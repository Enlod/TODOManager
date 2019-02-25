//
//  AnimationAssembler.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol AnimationAssembler {
    func resolveContext() -> AnimationContext
    func resolveExecutor() -> AnimationExecutorProtocol
}

extension AnimationAssembler {
    func resolveContext() -> AnimationContext {
        return AnimationContext(executor: resolveExecutor())
    }
    
    func resolveExecutor() -> AnimationExecutorProtocol {
        return AnimationExecutorStub()
    }
}
