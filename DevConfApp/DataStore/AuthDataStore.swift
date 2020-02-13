//
//  AuthDataStore.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

protocol AuthDataStoreInterface {
    func fetchCurrentUser(complition: @escaping (String?) -> ())
    func login(email: String, password: String, complition: @escaping ((String?, Error?)) -> ())
    func signup(email: String, password: String, complition: @escaping ((String?, Error?)) -> ())
}

class AuthDataStore: AuthDataStoreInterface {
    func fetchCurrentUser(complition: @escaping (String?) -> ()) {
        if let user = Auth.auth().currentUser {
            complition(user.uid)
        } else {
            complition(nil)
        }
    }
    
    func login(email: String, password: String, complition: @escaping ((String?, Error?)) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                complition((nil, err))
            } else if let result = result {
                complition((result.user.uid, nil))
            } else {
                complition((nil, nil))
            }
        }
    }
    
    func signup(email: String, password: String, complition: @escaping ((String?, Error?)) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                complition((nil, err))
            } else if let result = result {
                complition((result.user.uid, nil))
            } else {
                complition((nil, nil))
            }
        }
    }
}
