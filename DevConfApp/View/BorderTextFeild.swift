//
//  BorderTextFeild.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/29.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class BorderTextFeild: UITextField {
    var borderColor: UIColor!
    
    init(borderColor: UIColor = .black) {
        super.init(frame: CGRect.zero)
        
        self.borderColor = borderColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupBorder(borderColor: self.borderColor)
    }
    
    func setupBorder(borderColor: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - 2.0, width: self.frame.width, height: 2.0)
        border.backgroundColor = borderColor.cgColor
        self.layer.addSublayer(border)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 0)
    }
}
