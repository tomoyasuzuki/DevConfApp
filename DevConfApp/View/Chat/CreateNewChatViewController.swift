//
//  CreateNewChatViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/04.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CreateNewChatViewController: UIViewController {
    let viewModel = CreateNewChatViewModel()
    let picker = PhotoController()
    
    var categorySelected: PublishSubject<String> = PublishSubject()
    var tagSelected: PublishSubject<String> = PublishSubject()
    
    var headerView: UIView = {
        let view = GradientView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60),
                                startColor: Const.color.vividBlue.cgColor,
                                endColor: Const.color.vividLightBlue.cgColor)
        return view
    }()
    
    var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "チャットを作成"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_icon_black")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var chatImageView: UIImageView = {
        let view = CircleImageView()
        view.backgroundColor = Const.color.whiteSmoke
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    var chatTitleTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .clear
        view.borderStyle = .none
        view.placeholder = "チャット名を入力"
        view.font = .boldSystemFont(ofSize: 20.0)
        return view
    }()
    
    var firstBorder = BorderView()
    
    var descriptionTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .clear
        view.borderStyle = .none
        view.placeholder = "説明文を入力"
        return view
    }()
    
    var secondBorder = BorderView()
    
    var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "カテゴリー"
        return label
    }()
    
    var inputtedCategoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var thirdBorder = BorderView()
    
    var categoryNavButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_icon_black"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(navToCategory), for: .touchUpInside)
        return button
    }()
    
    var tagNavButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_icon_black"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var forthBorder = BorderView()
    
    var tagTitleLabel: UILabel = {
        let label = UILabel ()
        label.text = "タグ"
        return label
    }()
    
    var inuputtedTagLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var createButton: UIButton = {
        let button = GradientButton(frame: CGRect(x: 0, y: 0, width: 250, height: 40),
                                    startColor: Const.color.vividBlue.cgColor,
                                    endColor: Const.color.vividLightBlue.cgColor,
                                    cornerRadius: 20.0)
        button.setTitle("作成", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        headerView.addSubview(headerTitleLabel)
        headerView.addSubview(closeButton)
        view.addSubview(chatImageView)
        view.addSubview(chatTitleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(categoryTitleLabel)
        view.addSubview(inputtedCategoryLabel)
        view.addSubview(tagTitleLabel)
        view.addSubview(inuputtedTagLabel)
        view.addSubview(categoryNavButton)
        view.addSubview(tagNavButton)
        view.addSubview(createButton)
        view.addSubview(firstBorder)
        view.addSubview(secondBorder)
        view.addSubview(thirdBorder)
        view.addSubview(forthBorder)
        
        setupViewModel()
        autoLayout()
    }
    
    @objc func navToCategory() {
        let selectCategoryView = SelectCategoryViewController()
        
        selectCategoryView.category = { [weak self] category in
            guard let self = self else { return }
            self.inputtedCategoryLabel.text = category
        }
        
        self.present(selectCategoryView, animated: true, completion: nil)
    }
    
    @objc func navToTag() {
//        let selectTagView = SelectTagViewController()
//
////        selectTagView.tag { [weak self] tag in
////            guard let self = self else { return }
////            self.inputtedTagLabel.text = tag
////        }
    }
    
    func setupPicker() {
        let disposeBag = DisposeBag()
        
        picker.cancelObserver
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        picker.imagePickerObserver
            .subscribe(onNext: { image in
                
            }).disposed(by: disposeBag)
    }
    
    func setupViewModel() {
        let disposeBag = DisposeBag()
        let input = CreateNewChatViewModel.Input(chatTitleDidChange: self.chatTitleTextField.rx.text.orEmpty.asDriverWithEmpty(),
                                                 descriptionDidChange: self.descriptionTextField.rx.text.orEmpty.asDriverWithEmpty(), categorySelected: self.categorySelected.asDriverWithEmpty(),
                                                 tagSelected: self.tagSelected.asDriverWithEmpty(),
                                                 createButtonTapped: self.createButton.rx.tap.asDriverWithEmpty())
        
        let output = viewModel.bind(input: input)
        
        categorySelected
            .bind(to: self.inputtedCategoryLabel.rx.text)
            .disposed(by: disposeBag)
        
        tagSelected
            .bind(to: self.inuputtedTagLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        output.addCompleted
            .drive(onNext: { _ in
                print("comp")
            }).disposed(by: disposeBag)
        
        
    }
    
    
    func autoLayout() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(14)
            make.size.equalTo(35).multipliedBy(1.0)
        }
        
        chatImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(80).multipliedBy(1.0)
        }
        
        chatTitleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(chatImageView)
            make.left.equalTo(chatImageView.snp.right).offset(16)
        }
        
        firstBorder.snp.makeConstraints { make in
            make.top.equalTo(chatImageView.snp.bottom).offset(40)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(firstBorder.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        secondBorder.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(10)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(secondBorder.snp.bottom).offset(10)
            make.left.equalTo(descriptionTextField)
        }
        
        inputtedCategoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryTitleLabel)
            make.right.equalTo(categoryNavButton.snp.left).offset(-10)
        }
        
        categoryNavButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryTitleLabel)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        thirdBorder.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(10)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tagTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdBorder.snp.bottom).offset(10)
            make.left.equalTo(categoryTitleLabel)
        }
        
        inuputtedTagLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tagTitleLabel)
            make.right.equalTo(tagNavButton.snp.left).offset(-10)
        }
        
        tagNavButton.snp.makeConstraints { make in
            make.centerY.equalTo(tagTitleLabel)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        forthBorder.snp.makeConstraints { make in
            make.top.equalTo(tagTitleLabel.snp.bottom).offset(10)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        createButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(forthBorder.snp.bottom).offset(40)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
    }
}
