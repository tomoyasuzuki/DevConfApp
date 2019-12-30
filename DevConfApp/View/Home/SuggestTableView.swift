//
//  SuggestTableView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class SuggestTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        automaticallyAdjustsScrollIndicatorInsets = false
        isHidden = true
        backgroundColor = .lightGray
        register(UITableViewCell.self, forCellReuseIdentifier: "SUGGEST")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
