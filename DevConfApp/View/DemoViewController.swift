//
//  DemoViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/02.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, PortFolioViewDelegate {
    var pView = PortFolioView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pView)
        pView.delegate = self
        
        pView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func portFoliaTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func portFoliaTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortFolioTableViewCell", for: indexPath) as! PortFolioTableViewCell
        print("portFoliaTableView")
        return cell
    }
    
    func addButtonDidTap() {
        print("add button did tap")
    }
}
