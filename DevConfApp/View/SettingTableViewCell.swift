//
//  SettingTableViewCell.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/08.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

enum SettingSection: Int {
    case account = 0
    case push = 1
    case help = 2
}

class SettingTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_icon"))
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(10)
            
        }
    }
    
    func setup(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            switch row {
            case 0:
                titleLabel.text = "ユーザー名"
            case 1:
                titleLabel.text = "メールアドレス"
            default:
                break
            }
        case 1:
            switch row {
            case 0:
                titleLabel.text = "プッシュ通知"
            default:
                break
            }
        case 2:
            titleLabel.text = "ヘルプ"
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
