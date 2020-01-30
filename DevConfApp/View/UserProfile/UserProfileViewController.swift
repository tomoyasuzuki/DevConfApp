//
//  UserProfileViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/31.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import TagListView
import DynamicBlurView

class UserProfileViewController: UIViewController, UIScrollViewDelegate {
    var backgroundImageContainer = UIView()
    
    var naviBarTitle: UILabel = {
        let label = UILabel()
        label.text = "tomoya"
        return label
    }()
    
    var tabEditButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "edit_icon")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(UIImage(named: "edit_icon")!.withRenderingMode(.alwaysTemplate), for: .highlighted)
        button.tintColor = .white
        button.backgroundColor = .clear
        return  button
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.delegate = self
        return scroll
    }()
    
    var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = Const.color.whiteSmoke
        view.image = UIImage(named: "sample_background_image")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    var profileImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        view.layer.cornerRadius = view.frame.size.height / 2
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2.0
        view.backgroundColor = Const.color.whiteSmoke
        return view
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45.0)
        label.textColor = .white
        label.text = "Tomoya"
        return label
    }()
    
    var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "iOS Engineer"
        return label
    }()
    
    var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "setting_icon")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(UIImage(named: "setting_icon")!.withRenderingMode(.alwaysTemplate), for: .highlighted)
        button.tintColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    var editProfileButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(UIImage(named: "edit_icon")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(UIImage(named: "edit_icon")!.withRenderingMode(.alwaysTemplate), for: .highlighted)
        button.tintColor = .white
        button.backgroundColor = Const.color.vividLightBlue
        button.layer.cornerRadius = button.frame.size.height / 2
        button.clipsToBounds  = true
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    var skillTagArea: TagListView = {
        let view = TagListView()
        view.applyDefault()
        view.addTag("Tag")
        view.addTag("Tag")
        view.addTag("Tag")
        return view
    }()
    
    var imageContainer = UIView()
    var textContainer = UIView()
    
    var intro = IntroduceView()
    var port = PortFolioView()
    
    var userProfileContainerView = UIView()
    
    private var animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut)
    private var animationProgress: CGFloat = 0.0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        imageContainer.backgroundColor = .darkGray
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(textContainer)
        
        backgroundImageView.addSubview(backgroundImageContainer)
        backgroundImageContainer.addSubview(profileImageView)
        backgroundImageContainer.addSubview(userNameLabel)
        backgroundImageContainer.addSubview(positionLabel)
        
        view.addSubview(settingButton)
        view.addSubview(naviBarTitle)
        view.addSubview(tabEditButton)
        
        view.addSubview(editProfileButton)
        backgroundImageContainer.addSubview(skillTagArea)
        
        
        textContainer.addSubview(intro)
        textContainer.addSubview(port)
        
        naviBarTitle.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.centerX.equalToSuperview()
        }
        
        tabEditButton.snp.makeConstraints { make in
            make.centerY.equalTo(settingButton)
            make.right.equalTo(settingButton.snp.left).offset(-10)
            make.size.equalTo(20)
        }
        
        scrollView.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
        }
        
        imageContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        }
        
        backgroundImageContainer.snp.makeConstraints { make in
            make.edges.equalTo(backgroundImageView)
        }
        
        backgroundImageView.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(imageContainer)
            
            //** Note the priorities
            make.top.equalTo(view).priority(.high)
            
            //** We add a height constraint too
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            
            //** And keep the bottom constraint
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        textContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(imageContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        intro.snp.makeConstraints {
            make in
            
            make.top.right.left.equalTo(textContainer)
        }
        
        port.snp.makeConstraints { make in
            make.top.equalTo(intro.snp.bottom)
            make.right.left.bottom.equalTo(textContainer)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundImageView)
            make.left.equalTo(backgroundImageView).offset(10)
        }
        
        positionLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalTo(userNameLabel)
        }
        
        skillTagArea.snp.makeConstraints { make in
            make.top.equalTo(positionLabel.snp.bottom).offset(10)
            make.left.equalTo(positionLabel)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel)
            make.width.equalTo(70)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(1.0)
            make.right.equalToSuperview().offset(-15)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundImageView.snp.bottom)
            make.centerX.equalTo(view.snp.right).offset(-40)
            make.size.equalTo(40)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(20)
        }
        
        settingButton.addTarget(self, action: #selector(navigateToSetting), for: .touchUpInside)
    }
    
    @objc func navigateToSetting() {
        self.present(UINavigationController(rootViewController: SettingViewController()), animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 背景画像をフェードイン、フェードアウトさせる
        self.backgroundImageContainer.alpha = 1 - ((scrollView.contentOffset.y - 60) / 100)
        
        if scrollView.contentOffset.y > 40 && self.editProfileButton.frame.size.height <= 40, scrollView.contentOffset.y <= 300 {
            // 編集ボタンを小さくする、大きくする
            self.editProfileButton.snp.remakeConstraints { make in
                make.centerY.equalTo(backgroundImageView.snp.bottom)
                make.centerX.equalTo(view.snp.right).offset(-40)
                make.size.equalTo(40 - (scrollView.contentOffset.y - 40) * 0.2)
            }
            self.editProfileButton.layer.cornerRadius = (40 - (scrollView.contentOffset.y - 40) * 0.2) / 2
            self.editProfileButton.alpha = 1 - ((scrollView.contentOffset.y - 60) / 100)
        }
    }
}
