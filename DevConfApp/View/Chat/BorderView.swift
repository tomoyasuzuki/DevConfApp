//
//  BorderView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/05.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class BorderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Const.color.whiteSmoke
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
