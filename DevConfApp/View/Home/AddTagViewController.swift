//
//  AddTagViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxFirebase
import FirebaseFirestore

protocol TagDelegate {
    func tagDidSelected(_ text: TagModel)
}

class AddTagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    let db = Firestore.firestore()
    
    var tags: [TagModel] = []
    var naviBarHeight: ConstraintOffsetTarget?
    
    let disposeBag = DisposeBag()
    
    var delegate: TagDelegate?
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "タグを検索する"
        bar.delegate = self
        
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
        table.register(TagTableViewCell.self, forCellReuseIdentifier: "TAGCELL")
        table.tableFooterView = UIView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        view.addSubview(tagTableView)
        
        if let nav = navigationController {
            self.naviBarHeight = nav.navigationBar.frame.size.height
        }
        
        self.configureConstraints()
        self.observeTags()
    }
    
    // MARK: Layout
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Observers
    
    func observeTags() {
        searchBar.rx.text.asObservable()
            .subscribe(onNext: { [weak self] text in
                guard let text = text else { return }
                self?.search(text)
                self?.tagTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    // MARK: TableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAGCELL", for: indexPath) as! TagTableViewCell
        if !tags.isEmpty && tags.count >= 1 {
            cell.tagNameLabel.text = tags[indexPath.row].title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tagDidSelected(self.tags[indexPath.row])
        
        self.dismissVC()
    }
    
    // MARK: SearchBarDelegate
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        self.search(text)
        self.tagTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        self.search(text)
        self.tagTableView.reloadData()
    }
    // MARK: Searcch
    
    func search(_ text: String) {
        if !tags.isEmpty {
            self.tags = []
        }
        
        self.tags.append(TagModel(title: text))
        
        db.collection(Const.tag)
            .whereField(Const.title, isEqualTo: text)
            .addSnapshotListener { [weak self] snp, err in
                if snp == nil || err != nil {
                    return
                }
                
                snp?.documentChanges.forEach { change in
                    let data = change.document.data()
                    
                    if let tag = TagModel(data: data) {
                        self?.tags.append(tag)
                    }
                }
        }
    }
}
