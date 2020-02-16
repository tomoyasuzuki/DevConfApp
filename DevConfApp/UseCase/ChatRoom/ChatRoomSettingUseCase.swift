//
//  ChatRoomSettingUseCase.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/11.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

class ChatRoomSettingUsecase {
    var repository: ChatRoomSettingRepositoryInterface
    
    init(repository: ChatRoomSettingRepositoryInterface) {
        self.repository = repository
    }
    
    func getChatRoomMembers(roomId: String) -> Observable<Result<[UserEntity], Error>> {
        self.repository.getChatRoomMembers(roomId: roomId)
    }
    
    func getChatRoomSettings(roomId: String) -> Observable<Result<RoomSettingEntity, Error>> {
        self.repository.getChatRoomSettings(roomId: roomId)
    }
    
    func updateChatRoomSetting(roomId: String, setting: RoomSettingEntity) -> Observable<Error?> {
        self.repository.updateChatRoomSetting(roomId: roomId, setting: setting)
    }
    
    func updateChatRoomMembers(roomId: String, newMember: UserEntity) -> Observable<Error?> {
        self.repository.updateChatRoomMembers(roomId: roomId, newMember: newMember)
    }
}
