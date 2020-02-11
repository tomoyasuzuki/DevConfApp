//
//  Translator.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Foundation

protocol TranslatorInterface {
    func translateMessage(_ data: [String : Any]) -> [MessageEntity]
    func translateChat(_ data: [String : Any]) -> ChatRoomEntity
    func translateUser(_ data: [String : Any]) -> UserEntity
    func translateRoomSetting(_ data: [String : Any]) -> RoomSettingEntity
    func translateMessageToData(message: MessageEntity) -> [String : Any]
    func translateChatToData(chat: ChatRoomEntity) -> [String : Any]
    func translateSettingToData(setting: RoomSettingEntity) -> [String : Any]
    func translateUserToData(user: UserEntity) -> [String : Any]
}

class Translator: TranslatorInterface {
    func translateSettingToData(setting: RoomSettingEntity) -> [String : Any] {
        return ["hoge": "hoge"]
    }
    
    func translateUserToData(user: UserEntity) -> [String : Any] {
        return ["hoge": "hoge"]
    }

    func translateMessage(_ data: [String : Any]) -> [MessageEntity] {
        return [MessageEntity(messageId: "hoge", senderId: "hoge", text: "", sentDate: Date(), imageUrl: "hoge", audioUrl: "hoge")]
    }
    
    func translateChat(_ data: [String : Any]) -> ChatRoomEntity {
        return ChatRoomEntity(roomId: "id", category: "hoge", tags: ["hoge"])
    }
    
    func translateUser(_ data: [String : Any]) -> UserEntity {
        return UserEntity(userId: "hoge", userName: "hoge")
    }
    
    func translateMessageToData(message: MessageEntity) -> [String : Any] {
        return ["hoge": "hoge"]
    }
    
    func translateChatToData(chat: ChatRoomEntity) -> [String : Any] {
        return ["hoge": "hoge"]
    }
    
    func translateRoomSetting(_ data: [String : Any]) -> RoomSettingEntity {
        return RoomSetting(roomId: "hoge", notifyOrNot: true)
    }
}
