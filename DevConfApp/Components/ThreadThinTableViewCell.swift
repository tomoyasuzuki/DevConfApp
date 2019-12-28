//
//  ThreadThinTableViewCell.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import TagListView
import SnapKit

final class ThreadThinTableViewCell: EllipseTableViewCell {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private var startDateLabel: UILabel = {
        return SubTitleLabel()
    }()
    
    private var commentCountLabel: UILabel = {
        return SubTitleLabel()
    }()
    
    private var tagsAreaView = TagListView()
    
    private var emptyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = false
        button.setTitle("", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 20.0
        clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(startDateLabel)
        addSubview(commentCountLabel)
        addSubview(emptyButton)
        addSubview(tagsAreaView)
        
        tagsAreaView.alignment = .left
        tagsAreaView.cornerRadius = 14.0
        tagsAreaView.textColor = .white
        tagsAreaView.borderWidth = 1
        tagsAreaView.paddingX = 8
        tagsAreaView.paddingY = 8
        tagsAreaView.marginX = 10
        tagsAreaView.marginY = 10
        tagsAreaView.textFont = UIFont.systemFont(ofSize: 16)
        tagsAreaView.tagBackgroundColor = .black
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDataSouce(source: ThreadModel) {
        // TODO: データ反映全般の処理
        self.titleLabel.text = source.title
        self.commentCountLabel.text = source.posts.count.description
        
        setNeedsLayout()
    }
    
    private func configureConstraints() {
        tagsAreaView.frame.size = tagsAreaView.intrinsicContentSize
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.right.equalTo(contentView).offset(-10)
        }
        
        commentCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        tagsAreaView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }

        emptyButton.snp.makeConstraints { make in
            make.edges.equalTo(tagsAreaView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}
