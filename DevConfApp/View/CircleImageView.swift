//
//  CircleImageView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/24.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.size.width / 2
        clipsToBounds = true
        contentMode = .scaleAspectFit
    }
}
