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
    
    func updateUserProfileImage(id: String, image: UIImage) -> Observable<Error?> {
        self.repository.updateUserProfileImage(id: id, image: image).map { err in
            if err != nil {
                return ProfileError.updateImageFail
            } else {
                return nil
            }
        }
    }
    
    func updateUserInfo(id: String, nickName: String?, profileImageUrl: String?, introText: String?) -> Observable<Error?> {
        self.repository
            .updateUserField(id: id,
                             nickName: nickName,
                             profileImageUrl: profileImageUrl,
                             introText: introText)
            .map { err in
                if err != nil {
                    return ProfileError.updateInfoFail
                } else {
                    return nil
                }
        }
    }
}
