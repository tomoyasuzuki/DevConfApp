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

final class ThreadThinTableViewCell: EllipseTableViewCell, TagListViewDelegate {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Siwftプログラミングガイドをみんなで読み込む"
        label.font = .boldSystemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    private var startDateLabel: UILabel = {
        let label = SubTitleLabel()
        label.text = "2019/01/21"
        return label
    }()
    
    private var commentCountLabel: UILabel = {
        let label = SubTitleLabel()
        label.text = "2300"
        return label
    }()
    
    lazy var tagAreaView: TagListView = {
        let view = TagListView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 50))
        view.applyDefault()
        view.delegate = self
        view.addTag("Swift")
        view.addTag("iOS")
        view.addTag("プログラミング")
        return view
    }()
    
    private var emptyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = false
        button.setTitle("", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 26.0
        clipsToBounds = true
        
        contentView.backgroundColor = Const.color.whiteSmoke
        
        addSubview(titleLabel)
        addSubview(startDateLabel)
        addSubview(commentCountLabel)
        addSubview(emptyButton)
        addSubview(tagAreaView)
        
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
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.lessThanOrEqualToSuperview().offset(-10)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.right.equalTo(contentView).offset(-10)
        }
        
        commentCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        tagAreaView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }

        emptyButton.snp.makeConstraints { make in
            make.edges.equalTo(tagAreaView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}
