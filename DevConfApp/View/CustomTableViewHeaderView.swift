//
//  CustomTableViewHeaderView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/08.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import SnapKit

class CustomTableViewHeaderView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22.0)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
