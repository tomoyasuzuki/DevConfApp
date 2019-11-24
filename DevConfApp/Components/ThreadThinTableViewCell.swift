//
//  ThreadThinTableViewCell.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

final class ThreadThinTableViewCell: UITableViewCell {
    private var titleLabel: UILabel = {
        return UILabel()
    }()
    
    private var startDateLabel: UILabel = {
        return UILabel()
    }()
    
    private var commentCountLabel: RadiusLabel = {
        return RadiusLabel()
    }()
    
    private var textContentView: UIView = {
        return UIView()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(startDateLabel)
        addSubview(commentCountLabel)
        addSubview(textContentView)
        
        configureComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureComponents() {
        layer.cornerRadius = 14.0
        clipsToBounds = true
    }
}
