//
//  UnderBarTextField.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class UnderBarTextField: UITextField {
    init(barHeight: CGFloat = 1.0, barColor: UIColor = .black, frame: CGRect) {
        super.init(frame: frame)
        
        updateLayer(barHeight: barHeight, barColor: barColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateLayer(barHeight: CGFloat = 1.0, barColor: UIColor = .black) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - barHeight, width: self.frame.width, height: barHeight)
        border.backgroundColor = barColor.cgColor
        self.layer.addSublayer(border)
    }
}
