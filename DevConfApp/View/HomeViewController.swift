//
//  HomeViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private var tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "急上昇"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
    }
}

// MARK: Configure

extension HomeViewController {
    private func configureComponents() {
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ThreadThinTableViewCell.self, forCellReuseIdentifier: "ThreadThinTableViewCell")
        tableView.backgroundColor = .clear
    }
    
    private func configureConstraints() {
        // TODO: SnapKitのインストール
    }
}

// MARK: Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
