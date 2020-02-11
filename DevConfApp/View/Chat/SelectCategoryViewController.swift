//
//  SelectCategoryViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/08.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var headerView: UIView = {
        let view = GradientView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60),
                                startColor: Const.color.vividBlue.cgColor,
                                endColor: Const.color.vividLightBlue.cgColor)
        return view
    }()
    
    var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16.0)
        label.text = "カテゴリー"
        return label
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    let cateogries: [ChatCategory] = [.none, .front, .back, .infra]
    
    var category: ((String) -> ())?
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        headerView.addSubview(headerTitleLabel)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {make in
            make.top.equalTo(headerView.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cateogries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.tintColor = .black
        cell.textLabel?.text = self.cateogries[indexPath.row].rawValue
        
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
            category?(self.cateogries[indexPath.row].rawValue)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

}
