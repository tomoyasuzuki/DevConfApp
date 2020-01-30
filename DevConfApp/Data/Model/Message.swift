//
//  Message.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/25.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import MessageKit


struct Message: MessageType {
    var sender: SenderType
    
    var chatId: String
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
    var readUsers: [String]
    
    init(sender: SenderType, chatId: String, messageId: String, sentDate: Date, kind: MessageKind, readUsers: [String]) {
        self.sender = sender
        self.chatId = chatId
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
        self.readUsers = readUsers
    }
    
    func convertToDic() -> [String: Any] {
        var text = ""
        var imageUrl = ""
        var audioUrl = ""
        var messageKind = ""
        
        switch kind {
        case .text(let txt):
            text = txt
            messageKind = "text"
        case .photo(let photo):
            if let url = photo.url {
                imageUrl = url.absoluteString
                messageKind = "image"
            }
        case .audio(let audio):
            audioUrl = audio.url.absoluteString
            messageKind = "audio"
        default:
            break
        }
        
        return ["chatId": self.chatId, "senderId": self.sender.senderId, "senderName": self.sender.displayName,
                "sentDate": self.sentDate, "text": text, "imageUrl": imageUrl,
                "audioUrl": audioUrl, "messageKind": messageKind, "readUsers": self.readUsers]
    }
}
