//
//  PortFoliaView.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/02.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit

protocol PortFolioViewDelegate {
    func portFoliaTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func portFoliaTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func addButtonDidTap()
}

class PortFolioView: UIView {
    var delegate: PortFolioViewDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "作品一覧"
        label.font = .boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    lazy var table: UITableView = {
        let table = UITableView()
        table.register(PortFolioTableViewCell.self, forCellReuseIdentifier: "PortFolioTableViewCell")
        table.automaticallyAdjustsScrollIndicatorInsets = false
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 300
        return table
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(UIImage(named: "add_icon")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        button.tintColor = .lightGray
        return button
    }()
    
    let addTextLabel: UILabel = {
        let label = UILabel()
        label.text = "作品を追加する"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(table)
        addSubview(addButton)
        addSubview(addTextLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.lessThanOrEqualToSuperview().offset(-10)
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(500)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(table.snp.bottom).offset(20)
            make.left.equalTo(titleLabel)
            make.size.equalTo(20)
        }
        
        addTextLabel.snp.makeConstraints { make in
            make.centerY.equalTo(addButton)
            make.left.equalTo(addButton.snp.right).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonDidTap() {
        delegate?.addButtonDidTap()
    }
}

extension PortFolioView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortFolioTableViewCell", for: indexPath) as! PortFolioTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

