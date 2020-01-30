//
//  GradientView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/30.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var startColor: CGColor?
    var endColor: CGColor?
    
    var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.colors = [UIColor.hex(string: "#0000ff", alpha: 1.0).cgColor,
                        UIColor.hex(string: "#00ffff", alpha: 1.0).cgColor]
        return layer
    }()
    
    var radius: CGFloat?
    
    init(frame: CGRect, startColor: CGColor, endColor: CGColor, cornerRadius: CGFloat = 0) {
        super.init(frame: frame)
        
        self.startColor = startColor
        self.endColor = endColor
        self.radius = cornerRadius
        
        gradientLayer.colors = [startColor, endColor]
        
        self.updateGradientLayer(cornerRadius: cornerRadius)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateGradientLayer(cornerRadius: CGFloat = 0) {
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        updateGradientLayer(cornerRadius: radius!)
    }
}
