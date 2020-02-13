//
//  UserUseCase.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

class UserUseCase {
    var repository: UserRepositoryInterface
    
    init(repository: UserRepositoryInterface) {
        self.repository = repository
    }
    
    func getCurrentUser(id: String) -> Observable<UserEntity?> {
        self.repository.fetchCurrentUser(id: id)
    }
    
    func getChatRoomMembers(roomId: String) -> Observable<[UserEntity]?> {
        self.repository.fetchChatRoomMembers(roomId: roomId)
    }
    
    func addNewUser(user: UserEntity) -> Observable<Error?> {
        self.repository.addNewUser(user: user)
    }
    
    func updateUser(user: UserEntity) -> Observable<Error?> {
        self.repository.updateUser(user: user)
    }
}
