//
//  SelfIntroduceView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/02.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class IntroduceView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "自己紹介"
        label.font = .boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.text = "自己紹介を記入しましょう"
        view.backgroundColor = Const.color.whiteSmoke
        view.layer.cornerRadius = 14.0
        view.clipsToBounds = true
        return view
    }()
    
    let moreLabel: UILabel = {
        let label = SubTitleLabel()
        label.text = "さらに表示"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(textView)
        self.addSubview(moreLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(300)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func extendTextViewHeight() {
        
    }
    
    func shortenTextViewHeight() {
        
    }
}
