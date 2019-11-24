//
//  TagLabel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class RadiusLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 14.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
