//
//  Translator.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Foundation
import Firebase

protocol TranslatorInterface {
    func translateMessage(_ data: [String : Any]) -> MessageEntity
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
        return ["roomId": setting.roomId, "notifyOrNot": setting.notifyOrNot]
    }
    
    func translateUserToData(user: UserEntity) -> [String : Any] {
        return ["userId": user.userId, "userName": user.userName, "profileImageUrl": "", "belongRooms": []]
    }
    
    func translateMessage(_ data: [String : Any]) -> MessageEntity {
        let messageId = data["messageId"] as? String ?? ""
        let senderId = data["senderId"] as? String ?? ""
        let text = data["text"] as? String ?? ""
        let sentDate = data["sentDate"] as? Timestamp
        let imageUrl = data["imageUrl"] as? String ?? ""
        let audioUrl = data["audioUrl"] as? String ?? ""
        let readUsers = data["readUsers"] as? [String] ?? [""]
        
        return MessageEntity(messageId: messageId, senderId: senderId, text: text, sentDate: sentDate!.dateValue(),
                             imageUrl: imageUrl, audioUrl: audioUrl, readUsers: readUsers)
    }
    
    func translateChat(_ data: [String : Any]) -> ChatRoomEntity {
        let roomId = data["roomId"] as? String ?? ""
        let roomTitle = data["roomTitle"] as? String ?? ""
        let category = data["category"] as? String ?? ""
        let tags = data["tags"] as? [String] ?? [""]
        
        return ChatRoomEntity(roomId: roomId, roomTitle: roomTitle, category: category, tags: tags)
    }
    
    func translateUser(_ data: [String : Any]) -> UserEntity {
        return UserEntity(userId: data["userId"] as? String ?? "",
                          userName: data["userName"] as? String ?? "")
    }
    
    func translateMessageToData(message: MessageEntity) -> [String : Any] {
        return ["messageId": message.messageId, "senderId": message.senderId, "text": message.text,
                "sentDate": Timestamp(date: message.sentDate), "imageUrl": message.imageUrl,
                "audioUrl": message.audioUrl, "readUsers": message.readUsers]
    }
    
    func translateChatToData(chat: ChatRoomEntity) -> [String : Any] {
        return ["roomId": chat.roomId, "roomTitle": chat.roomTitle, "category": chat.category, "tags": chat.tags]
    }
    
    func translateRoomSetting(_ data: [String : Any]) -> RoomSettingEntity {
        return RoomSettingEntity(roomId: data["roomId"] as? String ?? "",
                                 notifyOrNot: data["notifyOrNot"] as? Bool ?? false)
    }
}
