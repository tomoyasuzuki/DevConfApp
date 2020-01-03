//
//  LeftPaddingTextField.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    
    var padding: UIEdgeInsets?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(padding: UIEdgeInsets) {
        super.init(frame: CGRect.zero)
        
        self.padding = padding
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if let p = padding {
            return bounds.inset(by: UIEdgeInsets(top: p.top, left: p.left, bottom: p.bottom, right: p.right))
        }
        return super.textRect(forBounds: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if let p = padding {
            return bounds.inset(by: UIEdgeInsets(top: p.top, left: p.left, bottom: p.bottom, right: p.right))
        }
        return super.editingRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if let p = padding {
            return bounds.inset(by: UIEdgeInsets(top: p.top, left: p.left, bottom: p.bottom, right: p.right))
        }
        return super.placeholderRect(forBounds: bounds)
    }
}
