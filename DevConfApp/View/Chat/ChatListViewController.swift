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
        bar.placeholder = "検索"
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
        
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "編集", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editChatList))
    }
    
    @objc func editChatList() {
        // edit chat list
    }
    
    private func configureConstraints() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navHeight: CGFloat = (navigationController != nil) ? navigationController!.navigationBar.frame.size.height : 0
        let tabBarHeight: CGFloat = (self.tabBarController != nil) ? tabBarController!.tabBar.frame.size.height : 0
        
        print(navHeight)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight + navHeight)
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
