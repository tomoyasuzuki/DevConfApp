//
//  PlaceholderTextView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/19.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class PlaceholderTextView: UITextView, UITextViewDelegate {
    
    var placeholderText: String = "" {
        didSet {
            guard !placeholderText.isEmpty else { return }
            
            placeholderlabel.text = placeholderText
            placeholderlabel.sizeToFit()
        }
    }
    
    private lazy var placeholderlabel = UILabel(frame: CGRect(x: 8, y: 8, width: 0, height: 0))
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        
        addSubview(placeholderlabel)
        placeholderlabel.textColor = .gray
        
        delegate = self
        
        contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        font = placeholderlabel.font
        
        handle(text)
    }
    
    func handle(_ text: String) {
        placeholderlabel.isHidden = text.isEmpty ? false : true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        handle(textView.text)
    }
}
