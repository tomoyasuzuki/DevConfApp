//
//  ExUIView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/01.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 0, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0
        }, completion: completion)
    }
}

