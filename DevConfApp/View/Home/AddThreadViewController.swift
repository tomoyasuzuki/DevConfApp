//
//  AddThreadViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddThreadViewController: UIViewController {
    let viewModel = AddThreadViewModel()
    let disposeBag = DisposeBag()
    
    var tags: [String] = []
 
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "タイトル"
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        return label
    }()
    
    lazy var titleInput: UITextField = {
        let field = UnderBarTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 25))
        field.placeholder = "タイトルをつけよう"
        return field
    }()
    
    var textCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    var tagIconView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "tag_icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "タグ"
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        return label
    }()
    
    var tagInputtedField: UITextField = {
        let field = UnderBarTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 25))
        field.placeholder = "タグをつけてみよう"
        return field
    }()
    
    var tagAddButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 4
        button.setTitle("+", for: .normal)
        return button
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        return button
    }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(titleInput)
        view.addSubview(textCountLabel)
        view.addSubview(tagIconView)
        view.addSubview(tagInputtedField)
        view.addSubview(tagLabel)
        view.addSubview(tagAddButton)
        view.addSubview(addButton)
        view.addSubview(closeButton)
        
        addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        tagAddButton.addTarget(self, action: #selector(addTagButtonDidTap), for: .touchUpInside)
        
        configureObserver()
        configureConstraints()
    }
    
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
        titleInput.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleInput)
            make.left.equalTo(titleInput.snp.right).offset(10)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(titleInput.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        tagInputtedField.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        
        tagIconView.snp.makeConstraints { make in
            make.centerY.equalTo(tagInputtedField)
            make.right.equalTo(tagInputtedField.snp.left).offset(-10)
            make.size.equalTo(30)
        }
        
        tagAddButton.snp.makeConstraints { make in
            make.centerY.equalTo(tagInputtedField)
            make.left.equalTo(tagInputtedField.snp.right).offset(10)
            make.size.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(tagInputtedField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(30)
        }
    }
    
    private func configureObserver() {
        titleInput.rx.text
            .asObservable()
            .subscribe(onNext: { text in
                guard let text = text else { return }
                
                self.textCountLabel.text = text.count.description
            })
            .disposed(by: disposeBag)
    }
    
    
    @objc func addButtonDidTap() {
        // 投稿処理
        guard let text = titleInput.text else { return }
        
//        let thread = ThreadModel(threadId: "",
//                                 title: text,
//                                 createdAt: Date().description,
//                                 updatedAt: Date().description, tags: [], isActive: , clippingUsers: , posts: )
//        viewModel.addThread()
        
    }
    
    @objc func closeButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addTagButtonDidTap() {
        let vc = AddTagViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
