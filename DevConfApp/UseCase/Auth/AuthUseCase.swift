//
//  AuthUseCase.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//
import RxSwift
import FirebaseAuth

class AuthUseCase {
    var repository: AuthRepositoryInterface
    
    init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }
    
    func getCurrentUser() -> Observable<(String?, Error?)> {
        self.repository.fetchCurrentUser()
    }
    
    func login(email: String, password: String) -> Observable<(String?, Error?)> {
        let status = (self.validateEmail(email), self.validatePassword(password))
        
        switch status {
        case (.valid, .valid):
            return self.repository.login(email: email, password: password)
        case (.valid, .invalid):
            return Observable.of((nil, AuthError.passwordIsTooShort))
        case (.invalid, .valid):
            return Observable.of((nil, AuthError.emailIsInvalid))
        default:
            return Observable.of((nil, AuthError.emailIsInvalid))
        }
    }
    
    func signup(email: String, password: String) -> Observable<(String?, Error?)> {
        let status = (self.validateEmail(email), self.validatePassword(password))
        
        switch status {
        case (.valid, .valid):
            return self.repository.signup(email: email, password: password).map { uid, err in
                if let err = err {
                    if let code = AuthErrorCode(rawValue: err._code), code == .emailAlreadyInUse {
                        return (nil, AuthError.emailIsAlreadyUsed)
                    } else {
                        return (nil, CommonError.networkingError)
                    }
                } else if let uid = uid {
                    return (uid, nil)
                } else {
                    return (nil, CommonError.unknownError)
                }
            }
        case (.valid, .invalid):
            return Observable.of((nil, AuthError.passwordIsTooShort))
        case (.invalid, .valid):
            return Observable.of((nil, AuthError.emailIsInvalid))
        default:
            return Observable.of((nil, nil))
        }
    }
    
    private func validateEmail(_ email: String) -> ValidationStatus {
        if email.count <= 0 || !email.contains("@") || !email.contains(".") {
            return .invalid
        } else {
            return .valid
        }
    }
    
    private func validatePassword(_ password: String) -> ValidationStatus {
        if password.count >= 6 {
            return .valid
        } else {
            return .invalid
        }
    }
}
