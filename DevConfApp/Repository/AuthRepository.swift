//
//  AuthRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import Foundation

protocol AuthRepositoryInterface {
    func fetchCurrentUser() -> Observable<(String?, Error?)>
    func login(email: String, password: String) -> Observable<(String?, Error?)>
    func signup(email: String, password: String) -> Observable<(String?, Error?)>
}

class AuthRepository: AuthRepositoryInterface {
    var datastore: AuthDataStore
    var translator: Translator
    
    init(datastore: AuthDataStore, translator: Translator) {
        self.datastore = datastore
        self.translator = translator
    }
    
    func fetchCurrentUser() -> Observable<(String?, Error?)> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            
            guard let self = self else {
                observer.onNext((nil, nil))
                return disposables
            }
            
            self.datastore.fetchCurrentUser { uid in
                if let uid = uid {
                    observer.onNext((uid, nil))
                } else {
                    observer.onNext((nil, nil))
                }
            }
            
            return disposables
        }
    }
    
    func login(email: String, password: String) -> Observable<(String?, Error?)> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            
            guard let self = self else {
                observer.onNext((nil, nil))
                return disposables
            }
            
            self.datastore.login(email: email, password: password) { uid, err in
                if let err = err {
                    observer.onNext((nil, err))
                } else if let uid = uid {
                    observer.onNext((uid, nil))
                } else {
                    observer.onNext((nil, nil))
                }
            }
            
            return disposables
        }
    }
    
    func signup(email: String, password: String) -> Observable<(String?, Error?)> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            
            guard let self = self else {
                observer.onNext((nil, nil))
                return disposables
            }
            
            self.datastore.signup(email: email, password: password) { uid, err in
                if let err = err {
                    observer.onNext((nil, err))
                } else if let uid = uid {
                    observer.onNext((uid, nil))
                } else {
                    observer.onNext((nil, nil))
                }
            }
            
            return disposables
        }
    }
}
