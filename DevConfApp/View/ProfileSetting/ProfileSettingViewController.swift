//
//  ProfileSettingViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/17.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

final class ProfileSettingViewController: UIViewController {
    
    var viewModel: ProfileSettingViewModelInterface
    
    var image: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    
    let disposeBag = DisposeBag()

    init(viewModel: ProfileSettingViewModelInterface) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let iconImageView: UIImageView = {
        let view = CircleImageView()
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let cameraIconView: UIImageView = {
        let view = CircleImageView()
        view.image = UIImage(named: "camera_icon_black")
        view.backgroundColor = .clear
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        return view
    }()
    
    private let displayNameTextField: UITextField = {
        let field = BorderTextFeild(borderColor: .darkGray)
        field.placeholder = "ニックネーム"
        field.attributedPlaceholder = NSAttributedString(string: field.placeholder!,
                                                        attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        field.textAlignment = .left
        return field
    }()
    
    private let selfIntroTextView: UITextView = {
        let view = PlaceholderTextView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.placeholderText = "自己紹介文を書きましょう。"
        return view
    }()
    
    var nextButton: UIButton = {
        let button = GradientButton(frame: CGRect.zero,
                                    startColor: Const.color.vividBlue.cgColor,
                                    endColor: Const.color.vividLightBlue.cgColor,
                                    cornerRadius: 20.0)
        button.setTitle("次へ", for: .normal)
        button.setTitle("次へ", for: .highlighted)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        button.layer.borderWidth = 0
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Const.color.white242
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        view.addSubview(iconImageView)
        view.addSubview(cameraIconView)
        view.addSubview(displayNameTextField)
        view.addSubview(selfIntroTextView)
        view.addSubview(nextButton)
        
        self.navigationItem.title = "プロフィール設定"
        
        setupViewModel()
        autoLayout()
    }
    
    private func autoLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.centerX.equalToSuperview()
            make.size.equalTo(140)
        }
        
        cameraIconView.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView).offset(50)
            make.centerX.equalTo(iconImageView).offset(50)
            make.size.equalTo(30)
        }
        
        displayNameTextField.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        selfIntroTextView.snp.makeConstraints { make in
            make.top.equalTo(displayNameTextField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(250)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(selfIntroTextView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(45)
        }
    }
    
    private func setupViewModel() {
        let input = ProfileSettingInput(profileImage: image.asDriverWithEmpty(),
                                        nickName: displayNameTextField.rx.text.orEmpty.asDriverWithEmpty(),
                                        introText: selfIntroTextView.rx.text.orEmpty.asDriverWithEmpty(),
                                        nextButtonTapped: nextButton.rx.tap.asDriverWithEmpty())
        
        let output = viewModel.bind(input: input)
        
        output.settingUpdate
            .drive(onNext: { action in
                if let action = action as? ProfileSettingViewAction {
                    switch action {
                    case .navigateToHome:
                         // ホーム画面へ遷移
                        print("navigate to home")
                    case .showImageUploadError(let errMessage):
                        SVProgressHUD.showError(withStatus: errMessage)
                    case .showUserInfoUploadError(let errMessage):
                        SVProgressHUD.showError(withStatus: errMessage)
                    }
                }
            }).disposed(by: disposeBag)
        
        output.loading
            .drive(onNext: { isLoading in
                if isLoading {
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                }
            }).disposed(by: disposeBag)
    }
}
