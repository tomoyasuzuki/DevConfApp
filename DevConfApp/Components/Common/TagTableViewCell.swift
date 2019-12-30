//
//  TagTableViewCell.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    
    var tagIconView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "tag_icon"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var tagNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(tagIconView)
        contentView.addSubview(tagNameLabel)
        
        tagIconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        tagNameLabel.snp.makeConstraints { make in
            make.left.equalTo(tagIconView.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
