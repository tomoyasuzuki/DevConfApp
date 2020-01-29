//
//  FChat.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/27.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Firebase

struct FChat {
    let chatTitle: String
    let chatMembers: [FUser]
    let createdAt: TimeInterval
    let updatedAt: TimeInterval
    let latestMessage: FMessage
    let messages: [FMessage]
    
    init?(data: [String: Any]) {
        guard let chatTitle = data["chatTitle"] as? String ,
            let chatMembers = data["chatMembers"] as? [FUser] ,
            let createdAt = data["createdAt"] as? TimeInterval ,
            let updatedAt = data["latestMessage"] as? TimeInterval,
            let latestMessage = data["latestMessage"] as? FMessage,
            let messages = data["messages"] as? [FMessage] else {
                return nil
        }
        
        self.chatTitle = chatTitle
        self.chatMembers = chatMembers
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.latestMessage = latestMessage
        self.messages = messages
    }
    
    func convertToChat() -> Chat {
        let latest = self.latestMessage.convertToMessage()
        let messages = self.messages.map { $0.convertToMessage() }
        let members = self.chatMembers.map { $0.convertToUserModel() }
        
        // firebase の documentIdがchatIdになるので外から追加する
        return Chat(chatId: "", chatTitle: self.chatTitle, chatMembers: members,
                    createdAt: Date(timeIntervalSince1970: self.createdAt),
                    updatedAt: Date(timeIntervalSince1970: self.updatedAt),
                    latestMessage: latest, messages: messages)
    }
}
