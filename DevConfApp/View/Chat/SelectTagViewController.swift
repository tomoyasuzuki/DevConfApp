//
//  SelectTagViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/10.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectTagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    var tags: [TagEntity] = []
    
    var tag: ((String) -> ())?
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.left.right.bottom.equalToSuperview()
            
            if let nav = self.navigationController {
                let height = nav.navigationBar.frame.height
                make.top.equalToSuperview().offset(height)
            } else {
                make.top.equalToSuperview()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.tintColor = .black
        cell.textLabel?.text = self.tags[indexPath.row].title
        
        switch indexPath.row {
        case 0:
            cell.accessoryType = .checkmark
        default:
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), cell.accessoryType != .checkmark {
            cell.accessoryType = .checkmark
            
            if cell != tableView.visibleCells[0],  tableView.visibleCells[0].accessoryType != .none {
                tableView.visibleCells[0].accessoryType = .none
            }
            tag?(self.tags[indexPath.row].title)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

}
