//
//  SettingViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/08.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var naviBarHeight: CGFloat?
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nav = navigationController {
            naviBarHeight = nav.navigationBar.frame.height
            self.navigationItem.title = "設定"
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.barTintColor = .white
        }
        
        tableView.snp.makeConstraints { make in
            if let height = naviBarHeight {
                make.top.equalToSuperview().offset(height - 15)
            } else {
                make.edges.equalToSuperview()
                return
            }
            
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        
        switch section {
        case 0:
            view.setup(title: "アカウント")
        case 1:
            view.setup(title: "通知")
        case 2:
            view.setup(title: "ヘルプ")
        default:
            break
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        cell.setup(indexPath: indexPath)
        return cell
    }
}
