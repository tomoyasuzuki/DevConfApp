//
//  AddTagViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import SnapKit

class AddTagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tags: [String] = ["Swift", "DDD", "iOS"]
    var naviBarHeight: ConstraintOffsetTarget?
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "タグを検索する"
        
        let textField = bar.searchTextField
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.layer.cornerRadius = 6.0
        textField.clipsToBounds = true

        return bar
    }()
    
    lazy var tagTableView: UITableView = {
        let table = UITableView()
        table.automaticallyAdjustsScrollIndicatorInsets = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TAGCELL")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(searchBar)
        view.addSubview(tagTableView)
        
        self.configureConstraints()
    }
    
    private func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            // ナビバーがある場合はナビバーの高さ分だけスペースを空ける
            if let height = naviBarHeight {
                make.top.equalToSuperview().offset(height)
            } else {
                make.top.equalTo(view)
            }
            
            make.right.left.equalTo(view)
        }
        
        tagTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func passTag(_ tag: String, complition: (String) -> ()) {
        complition(tag)
    }
    
    // MARK: TableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAGCELL", for: indexPath)
        cell.textLabel?.text = tags[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タグを元のVCに渡す
        
        self.dismissVC()
    }
}
