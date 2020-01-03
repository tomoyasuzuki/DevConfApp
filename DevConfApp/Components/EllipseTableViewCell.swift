//
//  EllipseTableViewCell.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/25.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class EllipseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 24.0
        clipsToBounds = true
    }
}
