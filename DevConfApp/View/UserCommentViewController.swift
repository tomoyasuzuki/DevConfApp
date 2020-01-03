//
//  UserCommentViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/01.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class UserCommentViewController: UIViewController {
    let tabTitle: IndicatorInfo = "Comment"
    
    lazy var commentTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.register(ThreadThinTableViewCell.self, forCellReuseIdentifier: "THREADCELL")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(commentTableView)
        
        commentTableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension UserCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "THREADCELL", for: indexPath) as! ThreadThinTableViewCell
        return cell
    }
}

// MARK: InfoIndicatorDelegate

extension UserCommentViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return tabTitle
    }
}
