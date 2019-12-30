//
//  HomeViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Swinject

final class HomeViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    var addThreadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 4
        return button
    }()
    
    private let headerMargin: CGFloat = 10.0
    private let footerMargin: CGFloat = 10.0
    
    let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        view.addSubview(addThreadButton)
        
        addThreadButton.addTarget(self, action: #selector(addThreadButtonDidTap), for: .touchUpInside)
        
        configureNavigationBar()
        configureComponents()
        configureConstraints()
    }
    
    @objc func addThreadButtonDidTap() {
        let vc = AddThreadViewController()
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: Configure

extension HomeViewController {
    private func configureNavigationBar() {
//        navigationItem.title = "急上昇"
//        navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func configureComponents() {
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ThreadThinTableViewCell.self, forCellReuseIdentifier: "ThreadThinTableViewCell")
        tableView.backgroundColor = .clear
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }
        
        addThreadButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 60.0, height: 60.0))
        }
    }
}

// MARK: Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadThinTableViewCell", for: indexPath) as! ThreadThinTableViewCell
//        cell.configureDataSouce(source: viewModel.threads[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerMargin
    }
    
    private func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerMargin
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    private func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    private func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
}