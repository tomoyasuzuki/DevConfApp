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
import FirebaseFirestore

class AddThreadViewController: UIViewController {
    let viewModel = AddThreadViewModel()
    let disposeBag = DisposeBag()
    
    let db = Firestore.firestore()
    
    var tagsCount: Int = 0
    
    // タイトル
    
    var titleInput: PaddingTextField = {
        let field = PaddingTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        field.layer.cornerRadius = 18.0
        field.clipsToBounds = true
        field.backgroundColor = Const.color.whiteSmoke
        field.attributedPlaceholder = NSAttributedString(string: "タイトル", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        return field
    }()
    
    var textCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.backgroundColor = .clear
        return label
    }()
    
    // タグ
    
    var tagAreaBorderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24.0
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.backgroundColor = Const.color.whiteSmoke
        return view
    }()
    
    var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "タグ"
        label.textColor = .gray
        label.backgroundColor = .clear
        return label
    }()
    
    var firstPostTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = Const.color.whiteSmoke
        view.text = "最初のコメントを設定しましょう"
        view.textColor = .gray
        view.layer.cornerRadius = 24.0
        view.clipsToBounds = true
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return view
    }()
    
    lazy var tagAreaView: TagListView = {
        let view = TagListView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 50))
        view.textFont = .systemFont(ofSize: 15)
        view.tagBackgroundColor = Const.color.vividBlue
        view.textColor = .white
        view.shadowRadius = 2
        view.shadowOpacity = 0.4
        view.shadowColor = UIColor.black
        view.shadowOffset = CGSize(width: 1, height: 1)
        view.alignment = .left
        view.paddingY = 6
        view.paddingX = 10
        view.enableRemoveButton = true
        view.backgroundColor = .clear
        view.cornerRadius = 10.0
        view.clipsToBounds = true
        view.delegate = self
        return view
    }()
    
    var addTagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add_icon"), for: .normal)
        button.setImage(UIImage(named: "add_icon"), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var addButton: UIButton = {
        // frameを設定しないと背景のlayerにも影響を及ぼすよう
        let button = GradientButton(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 0,
                                                  height: 0),
                                    startColor: Const.color.vividBlue.cgColor,
                                    endColor: Const.color.vividLightBlue.cgColor, cornerRadius: 24.0)
        button.setTitle("スレッドを始める", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16.0)
        button.layer.cornerRadius = 24.0
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
        
        view.addSubview(titleInput)
        view.addSubview(textCountLabel)
        view.addSubview(tagAreaBorderView)
        view.addSubview(tagAreaView)
        view.addSubview(tagLabel)
        view.addSubview(firstPostTextView)
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
        titleInput.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.right.equalTo(titleInput).offset(-10)
            make.centerY.equalTo(titleInput)
            make.height.equalTo(titleInput)
        }
        
        tagAreaBorderView.snp.makeConstraints { make in
            make.top.equalTo(titleInput.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
        
        if tagsCount == 0 {
            tagLabel.snp.makeConstraints { make in
                make.centerY.equalTo(tagAreaBorderView)
                make.left.equalTo(tagAreaBorderView).offset(10)
            }
        }
        
        tagAreaView.snp.makeConstraints { make in
            make.top.equalTo(tagAreaBorderView).offset(10)
            make.height.equalTo(tagAreaBorderView)
            make.center.equalTo(tagAreaBorderView)
            make.left.equalTo(tagAreaBorderView).offset(10)
            make.width.equalTo(tagAreaBorderView.frame.width - 30)
        }
        
        firstPostTextView.snp.makeConstraints { make in
            make.top.equalTo(tagAreaBorderView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(tagAreaBorderView)
            make.height.equalTo(300)
        }
        
        addTagButton.snp.makeConstraints { make in
            make.centerY.equalTo(tagAreaBorderView)
            make.right.equalTo(tagAreaBorderView).offset(-10)
            make.size.equalTo(30).multipliedBy(1.0)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(firstPostTextView.snp.bottom).offset(50)
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
        self.tagsCount -= tagsCount
        
        if tagsCount == 0 {
            self.tagLabel.isHidden = false
            
            tagAreaBorderView.snp.makeConstraints { make in
                make.top.equalTo(titleInput.snp.bottom).offset(10)
                make.height.equalTo(50)
                make.right.equalToSuperview().offset(-10)
                make.left.equalToSuperview().offset(10)
            }
        } else {
            tagAreaBorderView.snp.remakeConstraints { make in
                make.top.equalTo(titleInput.snp.bottom).offset(10)
                make.height.equalTo(tagAreaView.intrinsicContentSize.height + 20)
                make.width.equalTo(tagAreaBorderView.frame.width - 30)
                make.right.equalToSuperview().offset(-10)
                make.left.equalToSuperview().offset(10)
            }
        }
    }
}

extension AddThreadViewController: TagDelegate {
    func tagDidSelected(_ text: TagModel) {
        self.tagLabel.isHidden = true
        self.tagAreaView.addTag(text.title)
        self.tagsCount += tagsCount
        
        db.collection(Const.tag).addDocument(data: ["title": text.title]) { err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
        }
        
        if tagAreaView.intrinsicContentSize.height > tagAreaBorderView.frame.height {
            tagAreaBorderView.snp.remakeConstraints { make in
                make.top.equalTo(titleInput.snp.bottom).offset(10)
                make.height.equalTo(tagAreaView.intrinsicContentSize.height + 20)
                make.width.equalTo(tagAreaBorderView.frame.width - 30)
                make.right.equalToSuperview().offset(-10)
                make.left.equalToSuperview().offset(10)
            }
        }
    }
}
