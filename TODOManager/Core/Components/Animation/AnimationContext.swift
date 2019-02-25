//
//  AnimationContext.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit

protocol AnimationExecutorProtocol {
    func execute(animated: Bool, info: AnimationContext.Info)
}

struct AnimationExecutorStub: AnimationExecutorProtocol {
    func execute(animated: Bool, info: AnimationContext.Info) {
        info.animations.forEach { $0() }
        info.completions.forEach { $0(true) }
    }
}

struct AnimationExecutor: AnimationExecutorProtocol {
    var stub: AnimationExecutorStub
    
    func execute(animated: Bool, info: AnimationContext.Info) {
        guard animated else {
            stub.execute(animated: animated, info: info)
            
            return
        }
        
        UIView.animate(
            withDuration: info.duration,
            delay: info.delay,
            options: info.options,
            animations: {
                info.animations.forEach { $0() }
            },
            completion: { cancelled in
                info.completions.forEach { $0(cancelled) }
            }
        )
    }
}

class AnimationContext {
    private let executor: AnimationExecutorProtocol
    private var info = Info()
    
    init(executor: AnimationExecutorProtocol) {
        self.executor = executor
    }
    
    func add(
        animation: @escaping () -> Void,
        completion: @escaping (_ finished: Bool) -> Void = { _ in }) {
        info.animations.append(animation)
        info.completions.append(completion)
    }
    
    func execute(animated: Bool) {
        executor.execute(animated: animated, info: info)
        info = Info()
    }
    
    struct Info {
        var animations = [() -> Void]()
        var completions = [(finished: Bool) -> Void]()
        
        var duration = 0.3
        var delay = 0.0
        var options = UIView.AnimationOptions.curveEaseInOut
    }
}
