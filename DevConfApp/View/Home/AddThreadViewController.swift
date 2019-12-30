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
import TagListView

class AddThreadViewController: UIViewController {
    let viewModel = AddThreadViewModel()
    let disposeBag = DisposeBag()
 
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
    
    var tagAreaView: TagListView = {
        let view = TagListView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        view.textFont = .systemFont(ofSize: 15)
        view.tagBackgroundColor = .blue
        view.textColor = .white
        view.shadowRadius = 2
        view.shadowOpacity = 0.4
        view.shadowColor = UIColor.black
        view.shadowOffset = CGSize(width: 1, height: 1)
        view.alignment = .center
        view.paddingY = 6
        view.paddingX = 10
        view.cornerRadius = 14
        view.clipsToBounds = true
        view.enableRemoveButton = true
        return view
    }()
    
    var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "タグ"
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        return label
    }()
    
    var addTagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add_icon"), for: .normal)
        button.setImage(UIImage(named: "add_icon"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
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
        view.addSubview(tagAreaView)
        view.addSubview(tagLabel)
        view.addSubview(addTagButton)
        view.addSubview(addButton)
        view.addSubview(closeButton)
        
        addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        addTagButton.addTarget(self, action: #selector(addTagButtonDidTap), for: .touchUpInside)
        
        configureObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.updateTagViewConstraints()
    }
    
    
    override func updateViewConstraints() {
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
        
        tagAreaView.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(24)
            make.size.equalTo(250)
            make.centerX.equalToSuperview()
        }
        
        addTagButton.snp.makeConstraints { make in
            make.centerY.equalTo(tagLabel)
            make.left.equalTo(tagAreaView.snp.right).offset(10)
            make.size.equalTo(40).multipliedBy(1.0)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(tagAreaView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(30)
        }
        
        super.updateViewConstraints()
    }
    
//    private func updateTagViewConstraints() {
//        tagAreaView.snp.remakeConstraints { make in
//            make.top.equalTo(tagLabel.snp.bottom).offset(24)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(tagAreaView.intrinsicContentSize.height)
//        }
//    }
    
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
        
    }
    
    @objc func closeButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addTagButtonDidTap() {
        let vc = AddTagViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}


extension AddThreadViewController: TagListViewDelegate {
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.removeTagView(tagView)
    }
}

extension AddThreadViewController: TagDelegate {
    func tagDidSelected(_ text: TagModel) {
        self.tagAreaView.addTag(text.title)
    }
}
