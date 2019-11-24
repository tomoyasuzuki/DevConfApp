//
//  SubTitleLabel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

final class SubTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = .gray
        font = self.font.withSize(11)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

