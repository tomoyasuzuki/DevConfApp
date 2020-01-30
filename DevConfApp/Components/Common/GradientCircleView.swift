//
//  GradientCircleView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/30.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class GradientCircleView: GradientView {
    var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect, startColor: CGColor, endColor: CGColor, cornerRadius: CGFloat = 0) {
        super.init(frame: frame, startColor: startColor, endColor: endColor, cornerRadius: cornerRadius)
        
        addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        clipsToBounds = true
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }
}
