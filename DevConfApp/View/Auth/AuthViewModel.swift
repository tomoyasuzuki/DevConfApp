//
//  AuthViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/15.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

struct AuthInput {
    let email: BehaviorRelay<String>
    let password: BehaviorRelay<String>
    let loginButtonTapped: Driver<Void>
    let signupButtonTapped: Driver<Void>
}

struct AuthOutput {
    let login: Driver<ViewAction>
    let signup: Driver<ViewAction>
}

protocol AuthViewModelInterface {
    func bind(input: AuthInput) -> AuthOutput
}

class AuthViewModel: AuthViewModelInterface {
    
    let authUseCase: AuthUseCase
    
    var uid: String?
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    let disposeBag = DisposeBag()
    
    func bind(input: AuthInput) -> AuthOutput {
        let login = input.loginButtonTapped
            .asObservable()
            .flatMap { [weak self] _ -> Observable<(String?, Error?)> in
                guard let sSelf = self else {
                    return Observable.of((nil, nil))
                }
                
                return sSelf.authUseCase.login(email: input.email.value, password: input.password.value)
            }
            .map { [weak self] uid, err -> ViewAction in
                guard let sSelf = self else { return CommonViewAction.unknownError }
                
                if let err = err {
                    let errMessage = sSelf.createErrorMessage(err)
                    
                    return AuthViewAction.showLoginError(errMessage)
                } else if let uid = uid {
                    sSelf.uid = uid
                    
                    let sucMessage = "ログイン成功"
                    return AuthViewAction.navigateToHome(sucMessage)
                } else {
                    let errMessage = "予期せぬエラーが発生しました。時間をおいて再度お試しください。"
                    
                    return AuthViewAction.showLoginError(errMessage)
                }
            }
            .asDriverWithEmpty()
        
        
        let signup = input.signupButtonTapped
            .asObservable()
            .flatMap { [weak self] _ -> Observable<(String?, Error?)> in
                guard let sSelf = self else {
                    return Observable.of((nil, nil))
                }
            
                return sSelf.authUseCase.signup(email: input.email.value, password: input.password.value)
            }
            .map { [weak self] uid, err -> ViewAction in
                guard let sSelf = self else { return CommonViewAction.unknownError }
                
                if let err = err {
                    let errMessage = sSelf.createErrorMessage(err)
                    
                    return AuthViewAction.showSignUpError(errMessage)
                } else if let uid = uid {
                    sSelf.uid = uid
                    
                    let sucMessage = "登録成功"
                    return AuthViewAction.navigateToProfileSetting(sucMessage)
                } else {
                    let errMessage = "予期せぬエラーが発生しました。時間をおいて再度お試しください。"
                    
                    return AuthViewAction.showSignUpError(errMessage)
                }
            }
            .asDriverWithEmpty()
        
        
        
        return AuthOutput(login: login, signup: signup)
    }
    
    private func createErrorMessage(_ err: Error) -> String {
        var errMessage: String = ""
        
        if let err = err as? AuthError {
            switch err {
            case .emailIsInvalid:
                errMessage = "メールアドレスの形式が正しくありません。"
            case .emailIsAlreadyUsed:
                errMessage = "このメールアドレスは既に使用されています。"
            case .passwordIsTooShort:
                errMessage = "パスワードは6文字以上である必要があります。"
            }
        } else if let err = err as? CommonError {
            switch err {
            case .networkingError:
                errMessage = "通信状態が不安定です。"
            case.unknownError:
                errMessage = "予期せぬエラーが発生しました。時間をおいて再度お試しください。"
            }
        }
        
        return errMessage
    }
}
