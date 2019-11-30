//
//  UserRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxFirebaseFirestore
import FirebaseFirestore
import Result
import RxSwift
import RxCocoa


protocol UserRepositoryProtocol {
    func fetchUser(id: String) -> Observable<UserModel>
    func observeUser(id: String) -> Observable<UserModel>
}

final class UserRepository: UserRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func fetchUser(id: String) -> Observable<UserModel> {
        self.db
            .collection("user")
            .document(id)
            .rx.getDocument()
            .compactMap { UserModel(data: $0.data())}
    }
    
    func observeUser(id: String) -> Observable<UserModel> {
        self.db
            .collection("user")
            .whereField("userId", isEqualTo: id)
            .rx.listen().map { snp in
                var user: UserModel!
                
                snp.documentChanges.forEach { doc in
                    let data = doc.document.data()
                    
                    if let _user = UserModel(data: data) {
                        user = _user
                    }
                }
                
                return user
        }
    }
}
