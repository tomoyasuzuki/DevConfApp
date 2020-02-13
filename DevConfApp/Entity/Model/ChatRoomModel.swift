//
//  ChatRoomEntitty.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Foundation

struct ChatRoomModel {
    var roomId: String
    var roomTitle: String
    var createdAt: Date
    var updatedAt: Date
    var members: [UserEntity]
    var messages: [MessageEntity]
    var setting: RoomSettingEntity?
    
    init(roomId: String, roomTitle: String, createdAt: Date, updatedAt: Date,
         members: [UserEntity], messages: [MessageEntity], setting: RoomSettingEntity? = nil) {
        self.roomId = roomId
        self.roomTitle = roomTitle
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.members = members
        self.messages = messages
        self.setting = setting
    }
}
