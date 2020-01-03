//
//  PortFolioTableViewCell.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/02.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

protocol PortFolioTableViewCellDelegate {
    func editButtonDidTap()
    func deleteButtonDidTap()
}

class PortFolioTableViewCell: EllipseTableViewCell {
    var delegate: PortFolioTableViewCellDelegate?
    
    let productImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = Const.color.white242
        return view
    }()
    
    let bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Const.color.whiteSmoke
        return view
    }()
    
    let productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.text = "Github / GihutbRepositorySearch"
        return label
    }()
    
    let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12.0)
        label.text = "GithubでRepositoryを検索するアプリを作りました"
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit_icon"), for: .normal)
        button.setImage(UIImage(named: "edit_icon"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(editButtonDidTap), for: .touchUpInside)
        button.tintColor = .darkGray
        button.backgroundColor = .clear
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash_icon"), for: .normal)
        button.setImage(UIImage(named: "trash_icon"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
        button.tintColor = .darkGray
        button.backgroundColor = .clear
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 20.0
        clipsToBounds = true
        
        contentView.addSubview(productImageView)
        contentView.addSubview(bottomBackgroundView)
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(deleteButton)
        contentView.addSubview(editButton)
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview()
            make.height.equalTo(250)
        }
        
        bottomBackgroundView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(productImageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomBackgroundView).offset(10)
            make.right.lessThanOrEqualTo(editButton.snp.left)
            make.left.equalToSuperview().offset(10)
        }
        
        productDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(15)
            make.left.equalTo(productTitleLabel)
            make.right.lessThanOrEqualTo(editButton.snp.left)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomBackgroundView)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(20)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomBackgroundView)
            make.right.equalTo(deleteButton.snp.left).offset(-15)
            make.size.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editButtonDidTap() {
        delegate?.editButtonDidTap()
    }
    
    @objc func deleteButtonDidTap() {
        delegate?.deleteButtonDidTap()
    }
}
