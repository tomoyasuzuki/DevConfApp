//
//  CircleNumberView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/24.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class CircleNumberView: UIView {
    
    var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
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
}
