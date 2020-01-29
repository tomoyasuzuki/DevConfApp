//
//  ExTextView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/08.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import SnapKit

class CustomTextView: UITextView {
    let placeholder = UILabel()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholder)
        
        placeholder.isHidden = true
        placeholder.textColor = .lightGray
        placeholder.font = .systemFont(ofSize: 14.0)
        self.delegate = self
        
        placeholder.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textView.text.isEmpty {
            placeholder.isHidden = true
        } else {
            placeholder.isHidden = false
        }
    }
}
