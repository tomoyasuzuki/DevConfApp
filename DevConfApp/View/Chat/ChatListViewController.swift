//
//  ChatListViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/24.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {
    var editLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.barTintColor = .black
        bar.layer.borderWidth = 0
        bar.searchTextField.attributedPlaceholder = NSAttributedString(string: "検索", attributes: [.foregroundColor: UIColor.white])
        bar.searchTextField.textColor = .white
        bar.searchTextField.backgroundColor = .darkGray
        bar.searchTextField.tintColor = .black
        bar.searchTextField.leftView?.tintColor = .black
        return bar
    }()
    
    lazy var chatListTableView: UITableView = {
        let view = UITableView()
        view.register(ChatListTableViewCell.self, forCellReuseIdentifier: "ChatListTableViewCell")
        view.delegate = self
        view.dataSource = self
        view.estimatedRowHeight = 60
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(editLabel)
        view.addSubview(searchBar)
        view.addSubview(chatListTableView)
        
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Chats"
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20.0)]
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "編集", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editChatList))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func editChatList() {
        // edit chat list
    }
    
    private func configureConstraints() {
//        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
//        let navHeight: CGFloat = (navigationController != nil) ? navigationController!.navigationBar.frame.size.height : 0
        let tabBarHeight: CGFloat = (self.tabBarController != nil) ? tabBarController!.tabBar.frame.size.height : 0
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview()
        }
        
        chatListTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        if tabBarHeight != 0 {
            chatListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight, right: 0)
        }
    }
}


extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // todo:refer to threads count in view model
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as! ChatListTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
