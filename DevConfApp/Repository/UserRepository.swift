//
//  UserRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxFirebaseFirestore
import FirebaseFirestore
import FirebaseAuth
import Result
import RxSwift
import RxCocoa

final class UserRepository {
    private let db = Firestore.firestore()
    // user model for firebase
    var currentUser: User? {
        return Auth.auth().currentUser
    }
    // user model for app
    var currentUserModel: Observable<UserModel?> {
        return Observable.create { observer in
            if let currentUser = Auth.auth().currentUser {
                let db = Firestore.firestore()
                db.collection("user").document(currentUser.uid).getDocument { snp, err in
                    if err != nil {
                        observer.onNext(nil)
                        return
                    }
                    
                    if let u = FUser(data: snp!.data()!) {
                        var user = u.convertToUserModel()
                        user.userId = snp!.documentID
                        observer.onNext(user)
                    }
                }
            } else {
                observer.onNext(nil)
            }
            
            return Disposables.create()
        }
    }
    
    var isLogin: Observable<Bool> {
        return Observable.create { observer in
            Auth.auth().addStateDidChangeListener { (_, user) in
                if user != nil {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
            }
            
            return Disposables.create()
        }
    }
    
    // MARK: SignIn
    func signIn(email: String, password: String) -> Observable<Result<Void, Error>> {
        return Observable.create { observer in
            Auth.auth().signIn(withEmail: email, password: password) { result, err in
                if let err = err {
                    observer.onNext(.failure(err))
                } else if result != nil {
                    observer.onNext(.success(()))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: SignUp
    func signUp(email: String, password: String) -> Observable<Result<Void, Error>> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else {
                return disposables
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if let err = err {
                    observer.onNext(.failure(err))
                } else if let result = result {
                    let user = UserModel(userId: result.user.uid, userName: result.user.uid, profileImageUrl: "",
                                         backgroundImageUrl: "", githubUrl: "", profession: "", tags: [],
                                         introduceText: "", works: [], messages: [], chats: [])
                    let data = user.convertToDic()
                    self.db.collection("user").document(result.user.uid).setData(data) { err in
                        if err != nil {
                            observer.onNext(.failure(err!))
                            return
                        }
                    }
                    observer.onNext(.success(()))
                }
            }
            
            return disposables
        }
    }
}

enum AuthError: Error {
    case signinError
    case signupError
}

