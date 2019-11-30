//
//  ExNavigationController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/25.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import UIKit

// NavigationBarのStatusBarは常に白基調とする
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
