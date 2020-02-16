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
    let login: Driver<Void>
    let signup: Driver<Void>
}

protocol AuthViewModelInterface {
    func bind(input: AuthInput) -> AuthOutput
}

class AuthViewModel: AuthViewModelInterface {
    
    let authUseCase: AuthUseCase
    
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
            .map { uid, err -> ViewAction in
                if let err = err {
                    return AuthViewAction.showLoginError(err)
                } else if let uid = uid {
                    return AuthViewAction.navigateToHome(uid)
                } else {
                    return CommonViewAction.unknownError
                }
            }
            .void()
            .asDriverWithEmpty()
        
        
        let signup = input.signupButtonTapped
            .asObservable()
            .flatMap { [weak self] _ -> Observable<(String?, Error?)> in
                guard let sSelf = self else {
                    return Observable.of((nil, nil))
                }
            
                return sSelf.authUseCase.signup(email: input.email.value, password: input.password.value)
            }
            .map { uid, err -> ViewAction in
                if let err = err {
                    return AuthViewAction.showLoginError(err)
                } else if let uid = uid {
                    return AuthViewAction.navigateToProfileSetting(uid)
                } else {
                    return CommonViewAction.unknownError
                }
            }
            .void()
            .asDriverWithEmpty()
        
        
        
        return AuthOutput(login: login, signup: signup)
    }
}
