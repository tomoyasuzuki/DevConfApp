//
//  AuthUseCase.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//
import RxSwift

class AuthUseCase {
    var repository: AuthRepositoryInterface
    
    init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }
    
    func getCurrentUser() -> Observable<(String?, Error?)> {
        self.repository.fetchCurrentUser()
    }
    
    func login(email: String, password: String) -> Observable<(String?, Error?)> {
        self.repository.login(email: email, password: password)
    }
    
    func signup(email: String, password: String) -> Observable<(String?, Error?)> {
        self.repository.signup(email: email, password: password)
    }
}
