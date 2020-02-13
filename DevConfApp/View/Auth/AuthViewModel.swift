//
//  AuthViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/29.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import SnapKit
import Firebase


class AuthViewModel {
    let userRepo = UserRepository()
    let disposeBag = DisposeBag()
    var email: String = ""
    var password: String = ""
    
    struct Input {
        let emailDidChange: Driver<String>
        let passwordDidChange: Driver<String>
        let signinButtonTapped: Driver<Void>
        let signupButtonTapped: Driver<Void>
        let forgetPasswordButtonTapped: Driver<Void>
    }
    
    struct Output {
        let buttonStatus: Driver<Bool>
        let signinCompleted: Driver<Result<Void, Error>>
        let signupCompleted: Driver<Result<Void, Error>>
        let loading: Driver<Bool>
    }
    
    
    func bind(input: Input) -> Output {
        let loading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        
        input.emailDidChange
            .asObservable()
            .subscribe(onNext: { email in
                self.email = email
            }).disposed(by: disposeBag)
        
        input.passwordDidChange
            .asObservable()
            .subscribe(onNext: { password in
                self.password = password
            }).disposed(by: disposeBag)
        
        let emailStream = input.emailDidChange.asObservable()
        let passwordStream = input.passwordDidChange.asObservable()
        
        let buttonStatus = Observable
            .zip(emailStream, passwordStream)
            .flatMap { email, password -> Observable<Bool> in
                if email != "" && password != "" {
                    return Observable.of(true)
                } else {
                    return Observable.of(false)
                }
            }
            .asDriverWithEmpty()
        
        let signInComp = input.signinButtonTapped.asObservable()
            .do(onNext: { _ in
                loading.accept(true)
            })
            .flatMap { _ -> Observable<Result<Void, Error>> in
                return self.userRepo.signIn(email: self.email, password: self.password)
            }
            .do(onNext: { _ in
                loading.accept(false)
            })
            .asDriverWithEmpty()
        
        let signUpComp = input.signupButtonTapped.asObservable()
            .do(onNext: { _ in
                loading.accept(true)
            })
            .flatMap { _ -> Observable<Result<Void, Error>> in
                return self.userRepo.signUp(email: self.email, password: self.password)
            }
            .do(onNext: { _ in
                loading.accept(false)
            })
            .asDriverWithEmpty()
        
        return Output(buttonStatus: buttonStatus, signinCompleted: signInComp,
                      signupCompleted: signUpComp, loading: loading.asDriverWithEmpty())
    }
}
