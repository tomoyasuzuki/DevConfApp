//
//  ExTagListView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/31.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import TagListView
import UIKit

extension TagListView {
    func applyDefault() {
        self.textFont = .systemFont(ofSize: 15)
        self.tagBackgroundColor = Const.color.vividBlue
        self.textColor = .white
        self.shadowRadius = 2
        self.shadowOpacity = 0.4
        self.shadowColor = UIColor.black
        self.shadowOffset = CGSize(width: 1, height: 1)
        self.alignment = .left
        self.paddingY = 6
        self.paddingX = 10
        self.enableRemoveButton = true
        self.backgroundColor = .clear
        self.cornerRadius = 10.0
        self.clipsToBounds = true
        self.enableRemoveButton = true
    }
}

