//
//  ChatRoomSettingRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/11.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ChatRoomSettingRepositoryInterface {
    func getChatRoomMembers(roomId: String) -> Observable<Result<[UserEntity], Error>>
    func getChatRoomSettings(roomId: String) -> Observable<Result<RoomSettingEntity, Error>>
    func updateChatRoomSetting(roomId: String, setting: RoomSettingEntity) -> Observable<Error?>
    func updateChatRoomMembers(roomId: String, newMember: UserEntity) -> Observable<Error?>
}

class ChatRoomSettingRepository: ChatRoomSettingRepositoryInterface {
    var datastore: ChatRoomSettingDataStore
    var translator: TranslatorInterface
    
    init(translator: TranslatorInterface, datastore: ChatRoomSettingDataStore) {
        self.translator = translator
        self.datastore = datastore
    }
    
    func getChatRoomMembers(roomId: String) -> Observable<Result<[UserEntity], Error>> {
        return self.datastore.getChatRoomMembers(roomId: roomId).map { result in
            switch result {
            case .success(let datas):
                let users: [UserEntity] = datas.map { self.translator.translateUser($0)}
                return .success(users)
            case .failure(let err):
                return .failure(err)
            }
        }
    }
    
    func getChatRoomSettings(roomId: String) -> Observable<Result<RoomSettingEntity, Error>> {
        return self.datastore.getChatRoomSetting(roomId: roomId).map { result in
            switch result {
            case .success(let data):
                return .success(self.translator.translateRoomSetting(data))
            case .failure(let err):
                return .failure(err)
            }
        }
    }
    
    func updateChatRoomSetting(roomId: String, setting: RoomSettingEntity) -> Observable<Error?> {
        let data = translator.translateSettingToData(setting: setting)
        return self.datastore.updateChatRoomSetting(roomId: roomId, data: data)
    }
    
    func updateChatRoomMembers(roomId: String, newMember: UserEntity) -> Observable<Error?> {
        let data = translator.translateUserToData(user: newMember)
        return self.datastore.updateChatRoomMembers(roomId: roomId, data: data)
    }
}
