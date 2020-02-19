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
import Swinject
import SVProgressHUD

class AuthViewController: UIViewController {
    private var viewModel: AuthViewModelInterface
    
    private let indicator = UIActivityIndicatorView()
    private let disposeBag = DisposeBag()
    
    init(viewModel: AuthViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bubbleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "speech_bubble_empty_icon"))
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Real World Chat App Tutorial !!"
        label.font = .boldSystemFont(ofSize: 20.0)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailInput: UITextField = {
        let view = BorderTextFeild(borderColor: .darkGray)
        view.placeholder = "Email"
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder!,
                                                        attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        view.textAlignment = .left
        return view
    }()
    
    lazy var passwordInput: UITextField = {
        let view = BorderTextFeild(borderColor: .darkGray)
        view.placeholder = "Password"
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder!,
                                                        attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        view.textAlignment = .left
        view.isSecureTextEntry = true
        return view
    }()
    
    var signInButton: UIButton = {
        let button = GradientButton(frame: CGRect(x: 0, y: 0, width: 250, height: 60),
                                    startColor: Const.color.vividBlue.cgColor,
                                    endColor: Const.color.vividLightBlue.cgColor,
                                    cornerRadius: 20.0)
        
        button.setTitle("ログイン", for: .normal)
        button.setTitle("ログイン", for: .highlighted)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        button.layer.borderWidth = 0
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = GradientButton(frame: CGRect(x: 0, y: 0, width: 250, height: 60),
                                    startColor: Const.color.vividBlue.cgColor,
                                    endColor: Const.color.vividLightBlue.cgColor,
                                    cornerRadius: 20.0)
        
        button.setTitle("新規登録", for: .normal)
        button.setTitle("新規登録", for: .highlighted)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        button.layer.borderWidth = 0
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        return button
    }()
    
    var forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("パスワードを忘れた方はこちら", for: .normal)
        button.setTitle("パスワードを忘れた方はこちら", for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.backgroundColor = .clear
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 12.0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Const.color.white242
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        indicator.center = view.center
        indicator.style = .large
        indicator.color = .black
        
        view.addSubview(indicator)
        view.addSubview(bubbleImageView)
        view.addSubview(titleLabel)
        view.addSubview(emailInput)
        view.addSubview(passwordInput)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(forgetPasswordButton)
        
        setupViewModel()
        autoLayout()
    }
    
    func setupViewModel() {
        let input = AuthInput(email: emailInput.rx.text.orEmpty.asDriverWithEmpty(),
                              password: passwordInput.rx.text.orEmpty.asDriverWithEmpty(),
                              loginButtonTapped: signInButton.rx.tap.asDriverWithEmpty(),
                              signupButtonTapped: signUpButton.rx.tap.asDriverWithEmpty())
        
        let output = viewModel.bind(input: input)
        
        output.login
            .drive(onNext: { [weak self] action in
                guard let sSelf = self else { return }
                
                sSelf.handleViewAction(action)
            }).disposed(by: disposeBag)
        
        output.signup
            .drive(onNext: { [weak self] action in
                guard let sSelf = self else { return }
                
                sSelf.handleViewAction(action)
            }).disposed(by: disposeBag)
    }
    
    private func handleViewAction(_ action: ViewAction) {
        if let action = action as? AuthViewAction {
            switch action {
            case .navigateToHome(let mes):
                
                self.showSuccess(message: mes)
            case .navigateToProfileSetting(let mes):
                
                self.showSuccess(message: mes)
            case .showLoginError(let mes):
                self.showError(message: mes)
            case .showSignUpError(let mes):
                self.showError(message: mes)
            case .showEmailInvalidError(let mes):
                self.showError(message: mes)
            case .showPasswordInvalidError(let mes):
                self.showError(message: mes)
            default:
                break
            }
        }
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showSuccess(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            let vc = resolver.resolve(ProfileSettingViewController.self)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func autoLayout() {
        
        bubbleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(70)
            make.size.equalTo(230)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(bubbleImageView).offset(-20)
            make.width.equalTo(150)
        }
        
        emailInput.snp.makeConstraints { make in
            make.top.equalTo(bubbleImageView.snp.bottom).offset(40)
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
            make.height.equalTo(45)
        }
        
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(45)
        }
    }
}

//extension AuthViewController: UITextFieldDelegate {
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        guard let text = textField.text else { return true }
//
//        switch textField.tag {
//        case 0:
//            self.email.accept(text)
//        case 1:
//            self.password.accept(text)
//        default:
//            break
//        }
//
//        return true
//    }
//}
