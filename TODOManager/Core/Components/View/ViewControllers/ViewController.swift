//
//  ViewController.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/26/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController, DisposeBagHolder {
    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
