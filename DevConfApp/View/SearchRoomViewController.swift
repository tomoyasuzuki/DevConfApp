//
//  SearchRoomViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/09.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import TagListView
import Firebase

class SearchRoomViewController: UIViewController, UIScrollViewDelegate {
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = Const.color.whiteSmoke
        bar.placeholder = "キーワード"
        bar.searchTextField.textColor = .lightGray
        bar.searchTextField.layer.cornerRadius = 8.0
        bar.searchTextField.heightAnchor.constraint(equalToConstant: 50)
        bar.searchTextField.clipsToBounds = true
        return bar
    }()
    
    let sortButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var tagAreaScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        return view
    }()
    
    let tagAreaView: TagListView = {
        let view = TagListView()
        view.applyDefault()
        view.addTag("Iot")
        view.addTag("React")
        view.addTag("PHP")
        return view
    }()
    
    let wrapView = UIView()
    
    var navHeight: CGFloat?
    
    var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "募集"
        self.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        if let navHeight = navigationController?.navigationBar.frame.size.height {
            self.navHeight = navHeight
        }

        view.addSubview(searchBar)
        view.addSubview(sortButton)
        view.addSubview(tagAreaScrollView)
        tagAreaScrollView.addSubview(wrapView)
        (wrapView).addSubview(tagAreaView)
        
        searchBar.snp.makeConstraints { make in
            if let height = navHeight {
                make.top.equalToSuperview().offset(height)
            } else {
                make.top.equalToSuperview()
            }
            
            make.right.left.equalToSuperview()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = startPoint.y
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.startPoint = scrollView.contentOffset
    }

}

