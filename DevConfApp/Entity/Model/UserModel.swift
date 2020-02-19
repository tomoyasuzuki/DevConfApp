//
//  UserModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Foundation

struct UserModel {
    var userId: String
    var userName: String
    var profileImageUrl: String
    var introText: String
    var tags: [String]
    var messages: [MessageEntity]
    var chats: [ChatRoomEntity]
    
    init(userId: String, userName: String, profileImageUrl: String, introText: String, 
         tags: [String], messages: [MessageEntity], chats: [ChatRoomEntity]) {
        self.userId = userId
        self.userName = userName
        self.profileImageUrl = profileImageUrl
        self.tags = tags
        self.messages = messages
        self.chats = chats
        self.introText = introText
    }
}
