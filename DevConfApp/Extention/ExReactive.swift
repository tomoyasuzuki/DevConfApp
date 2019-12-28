//
//  ExReactive.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UIViewController {
    private func controlEvent(for selector: Selector) -> ControlEvent<Void> {
        return ControlEvent(events: sentMessage(selector).map { _ in })
    }
    
    var loadView: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.loadView))
    }
    
    var viewDidLoad: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewDidLoad))
    }
    
    var viewWillAppear: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewWillAppear))
    }
    
    var viewDidAppear: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewDidAppear))
    }
}

extension ObservableType {
    func void() -> Observable<()>{
        return self.asObservable().map { _ in ()}
    }
}

extension ObservableConvertibleType {
    func asDriverWithEmpty() -> Driver<Element>{
        return self.asDriver(onErrorDriveWith: Driver.empty())
    }
}


