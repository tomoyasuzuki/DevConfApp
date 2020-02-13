//
//  UserRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift

protocol UserRepositoryInterface {
    func fetchCurrentUser(id: String) -> Observable<UserEntity?>
    func fetchChatRoomMembers(roomId: String) -> Observable<[UserEntity]?>
    func addNewUser(user: UserEntity) -> Observable<Error?>
    func updateUser(user: UserEntity) -> Observable<Error?>
}

class UserRepository: UserRepositoryInterface {
    var datastore: UserDataStoreInterface
    var translator: TranslatorInterface
    
    init(datastore: UserDataStoreInterface, translator: TranslatorInterface) {
        self.datastore = datastore
        self.translator = translator
    }
    func fetchCurrentUser(id: String) -> Observable<UserEntity?> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            
            guard let self = self else {
                observer.onNext(nil)
                return disposables
            }
            
            self.datastore.fetchCurrentUser(id: id) { data in
                if let data = data {
                    let user = self.translator.translateUser(data)
                    observer.onNext(user)
                } else {
                    observer.onNext(nil)
                }
            }
            
            return disposables
        }
    }
    
    func fetchChatRoomMembers(roomId: String) -> Observable<[UserEntity]?> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            
            guard let self = self else {
                observer.onNext(nil)
                return disposables
            }
            
            self.datastore.fetchChatRoomMembers(roomId: roomId) { datas in
                if let datas = datas {
                    var users: [UserEntity] = []
                    
                    datas.forEach { data in
                        let user = self.translator.translateUser(data)
                        users.append(user)
                    }
                    
                    observer.onNext(users)
                } else {
                    observer.onNext(nil)
                }
            }
            return disposables
        }
    }
    
    func addNewUser(user: UserEntity) -> Observable<Error?> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            
            guard let self = self else {
                observer.onNext(nil)
                return disposables
            }
            
            let data = self.translator.translateUserToData(user: user)
            
            self.datastore.addNewUser(data: data) { err in
                if let err = err {
                    observer.onNext(err)
                } else {
                    observer.onNext(nil)
                }
            }
            return disposables
        }
    }
    
    func updateUser(user: UserEntity) -> Observable<Error?> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            
            guard let self = self else {
                observer.onNext(nil)
                return disposables
            }
            
            let data = self.translator.translateUserToData(user: user)
            
            self.datastore.updateUser(id: user.userId, data: data) { err in
                if let err = err {
                    observer.onNext(err)
                } else {
                    observer.onNext(nil)
                }
            }
            return disposables
        }
    }
}

