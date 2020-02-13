//
//  MessageModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//
import MessageKit

/*

MessageModelはMessageEntityをMessageKitに適応させた形
本質的なEntityとは違うため、このモデルはPresenterを介してViewControllerでしか使用しない。

*/

struct MessageModel: MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
    var readUsers: [UserEntity]
    
    init(sender: SenderType, messageId: String, sentDate: Date, kind: MessageKind, readUsers: [UserEntity]) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
        self.readUsers = readUsers
    }
}
