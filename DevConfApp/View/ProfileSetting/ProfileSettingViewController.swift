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

final class ProfileSettingViewController: UIViewController {
    
    var viewModel: ProfileSettingViewModelInterface

    init(viewModel: ProfileSettingViewModelInterface) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        view.backgroundColor = Const.color.white242
        return view
    }()
    
    private let cameraIconView: UIImageView = {
        let view = CircleImageView()
        view.image = UIImage(named: "camera_icon_black")?
        .withAlignmentRectInsets(UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
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
        let view = UITextView()
        view.backgroundColor = Const.color.white242
        view.layer.cornerRadius = 14.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(iconImageView)
        view.addSubview(cameraIconView)
        view.addSubview(displayNameTextField)
        view.addSubview(selfIntroTextView)
        
        self.navigationItem.title = "プロフィール設定"
        
        setupViewModel()
        autoLayout()
    }
    
    private func autoLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        cameraIconView.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView).offset(35)
            make.centerX.equalTo(iconImageView).offset(35)
            make.size.equalTo(20)
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
    }
    
    private func setupViewModel() {
        
    }
}
