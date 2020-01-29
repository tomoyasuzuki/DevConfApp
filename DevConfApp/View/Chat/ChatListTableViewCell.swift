//
//  ChatListTableViewCell.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/24.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import SnapKit

class ChatListTableViewCell: UITableViewCell {
    var chatImageView: UIImageView = {
        let view = CircleImageView()
        view.layer.borderWidth = 2.0
        view.layer.borderColor = Const.color.whiteSmoke.cgColor
        view.image = UIImage(named: "default_user_icon")
        return view
    }()
    var chatTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Swiftについて語る会"
        return label
    }()
    
    var lastMessageLabel: UILabel = {
        let label = SubTitleLabel()
        label.text = "やっぱりswiftが最高じゃない"
        return label
    }()
    
    var unreadMessageCountView: UIView = {
        let view = CircleNumberView()
        view.backgroundColor = Const.color.vividBlue
        view.numberLabel.textColor = .white
        view.numberLabel.text = "4"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(chatImageView)
        contentView.addSubview(chatTitleLabel)
        contentView.addSubview(lastMessageLabel)
        contentView.addSubview(unreadMessageCountView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(userId: String) {
        // fetch threads data from firebase
    }
    
    private func configureConstraints() {
        chatImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(40)
            make.width.equalTo(chatImageView.snp.height).multipliedBy(1.0)
        }
        
        chatTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(chatImageView)
            make.left.equalTo(chatImageView.snp.right).offset(8)
        }
        
        lastMessageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(chatImageView)
            make.left.equalTo(chatTitleLabel)
        }
        
        unreadMessageCountView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
    }
}
