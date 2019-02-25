//
//  DisposeBagHolder.swift
//  TODOManager
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

protocol DisposeBagHolder {
    var disposeBag: DisposeBag { get }
}

extension Disposable {
    func disposed(by disposeBagHolder: DisposeBagHolder) {
        disposed(by: disposeBagHolder.disposeBag)
    }
}
