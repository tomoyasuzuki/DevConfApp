//
//  Chat.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/27.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Firebase

struct Chat {
    let chatId: String
    let chatTitle: String
    let chatMembers: [UserModel]
    let createdAt: Date
    let updatedAt: Date
    let latestMessage: Message?
    let messages: [Message]
    let readUsersCount: Int
    
    init(chatId: String, chatTitle: String, chatMembers: [UserModel], createdAt: Date,
         updatedAt: Date, latestMessage: Message?, messages: [Message], readUsersCount: Int) {
        self.chatId = chatId
        self.chatTitle = chatTitle
        self.chatMembers = chatMembers
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.latestMessage = latestMessage
        self.messages = messages
        self.readUsersCount = readUsersCount
    }
    
    // フィールドのみ追加
    // 整合性を保つためには chatmMembers, latestMessage, messages は外から追加する必要がある
    func convertToDic() -> [String: Any] {
        return ["chatTitle": self.chatTitle, "createdAt": self.createdAt,
                "updatedAt": self.updatedAt, "readUsersCount": self.readUsersCount]
    }
}


