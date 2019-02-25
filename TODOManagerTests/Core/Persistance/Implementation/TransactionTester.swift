//
//  TransactionTester.swift
//  TODOManagerTests
//
//  Created by Roman Voskovskyi on 9/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import XCTest
import RxSwift

struct TransactionTester: DisposeBagHolder {
    let disposeBag = DisposeBag()
    
    var transaction: PersistableTransactionMock
    
    func execute(_ tests: () -> Void) {
        var beginTransactionCount = 0
        var commitTransactionCount = 0
        
        transaction.onBegin
            .subscribe(onNext: { beginTransactionCount += 1 })
            .disposed(by: self)
        
        let transactionActionCheck = { (action: PublishSubject<Void>) in
            action
                .subscribe(onNext: {
                    XCTAssertEqual(beginTransactionCount, 1)
                    XCTAssertEqual(commitTransactionCount, 0)
                })
                .disposed(by: self)
        }
        
        transactionActionCheck(transaction.onUpdate)
        transactionActionCheck(transaction.onDelete)
        
        transaction.onCommit
            .filter { beginTransactionCount == 1 }
            .subscribe(onNext: { commitTransactionCount += 1 })
            .disposed(by: self)
        
        tests()
        
        XCTAssertEqual(beginTransactionCount, 1)
        XCTAssertEqual(commitTransactionCount, 1)
    }
}
