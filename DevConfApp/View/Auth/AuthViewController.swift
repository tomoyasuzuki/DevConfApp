//
//  AuthViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/27.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import SVProgressHUD

class AuthViewController: UIViewController {
    let indicator = UIActivityIndicatorView()
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Real World Chat App Tutorial !!"
        label.font = .boldSystemFont(ofSize: 20.0)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "このアプリは世にリリースされているアプリと（出来る限り）同じレベルの機能を持っています。そのため、このアプリの実装を理解することで、より実戦に近い知識を得られ（かもしれないと僕は思ってい）ます。"
        label.textAlignment = .center
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var emailInput: UITextField = {
        let view = BorderTextFeild(borderColor: .darkGray)
        view.placeholder = "Email"
        view.textAlignment = .left
        
        return view
    }()
    
    var passwordInput: UITextField = {
        let view = BorderTextFeild(borderColor: .darkGray)
        view.placeholder = "Password"
        view.textAlignment = .left
        view.isSecureTextEntry = true
        return view
    }()
    
    var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("ログイン", for: .normal)
        button.setTitle("ログイン", for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2.0
        button.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("新規登録", for: .normal)
        button.setTitle("新規登録", for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2.0
        button.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        return button
    }()
    
    var foretPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("パスワードを忘れた方はこちら", for: .normal)
        button.setTitle("パスワードを忘れた方はこちら", for: .highlighted)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 10.0)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        indicator.center = view.center
        indicator.style = .large
        indicator.color = .black
        
        view.addSubview(indicator)

        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(emailInput)
        view.addSubview(passwordInput)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(foretPasswordButton)
        
        
        autoLayout()
        setupViewModel()
    }
    
    
    func autoLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50 + UIApplication.shared.statusBarFrame.size.height)
            make.width.equalTo(200)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        
        emailInput.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        passwordInput.snp.makeConstraints { make in
            make.top.equalTo(emailInput.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordInput.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        foretPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
    }
    
    func setupViewModel() {
        let input = AuthViewModel.Input(emailDidChange: emailInput.rx.text.orEmpty.asDriverWithEmpty(),
                                        passwordDidChange: passwordInput.rx.text.orEmpty.asDriverWithEmpty(),
                                        signinButtonTapped: signInButton.rx.tap.asDriverWithEmpty(),
                                        signupButtonTapped: signUpButton.rx.tap.asDriverWithEmpty(),
                                        forgetPasswordButtonTapped: foretPasswordButton.rx.tap.asDriverWithEmpty())
        
        let output = viewModel.bind(input: input)
        
        output.signinCompleted
            .drive(onNext: { result in
                switch result {
                case .success(()):
                    // 画面遷移
                    print("hoge ")
                case .failure(let err):
                    self.showError(err)
                }
            }).disposed(by: disposeBag)
        
        output.signupCompleted
        .drive(onNext: { result in
            switch result {
            case .success(()):
                // 登録完了
                self.present(UserProfileViewController(), animated: true, completion: nil)
            case .failure(let err):
                self.showError(err)
            }
        }).disposed(by: disposeBag)
        
        output.buttonStatus
            .drive(onNext: { enable in
                self.signInButton.isEnabled = enable
                self.signUpButton.isEnabled = enable
            }).disposed(by: disposeBag)
        
        output.loading
            .drive(onNext: { loading in
                if loading {
                    self.indicator.startAnimating()
                } else {
                    if self.indicator.isAnimating {
                        self.indicator.stopAnimating()
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    func showSigninCompAlert() {
        let alert = UIAlertController.init(title: "Success", message: "success", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(_ error: Error) {
        let errCode = AuthErrorCode(rawValue: error._code)
        var errMessage = ""
        
        switch errCode {
        case .invalidEmail:
            errMessage = "メールアドレスの形式が間違っています"
        case .emailAlreadyInUse:
            errMessage = "このメールアドレスは既に使用されています"
        case .weakPassword:
            errMessage = "パスワードは6文字以上で入力してください"
        default:
            errMessage = "エラーが発生しました。\nしばらくしてから再度お試しください"
        }
        
        let alert = UIAlertController.init(title: "エラー", message: errMessage, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
