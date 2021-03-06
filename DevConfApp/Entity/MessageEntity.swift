//
//  Message.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//
import Foundation

struct MessageEntity {
    var messageId: String
    var senderId: String
    var text: String
    var sentDate: Date
    var imageUrl: String
    var audioUrl: String
    var readUsers: [String]
    
    init(messageId: String, senderId: String, text: String, sentDate: Date, imageUrl: String, audioUrl: String, readUsers: [String]) {
        self.messageId = messageId
        self.senderId = senderId
        self.text = text
        self.sentDate = sentDate
        self.imageUrl = imageUrl
        self.audioUrl = audioUrl
        self.readUsers = readUsers
    }
}
