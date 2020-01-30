//
//  FMessage.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/26.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//
import MessageKit
import Firebase

struct Sender: SenderType {
    var senderId: String
    
    var displayName: String
    
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}


struct Photo: MediaItem {
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
    
    init(url: URL, image: UIImage?, placeholderImage: UIImage = UIImage(named: "")!, size: CGSize = CGSize.zero) {
        self.url = url
        self.image = image
        self.placeholderImage = placeholderImage
        self.size = size
    }
}

struct Audio: AudioItem {
    var url: URL
    
    var duration: Float
    
    var size: CGSize
    
    init(url: URL, duration: Float, size: CGSize = CGSize.zero) {
        self.url = url
        self.duration = duration
        self.size = size
    }
}


struct FMessage {
    let chatId: String
    let senderId: String
    let senderName: String
    let sentDate: Timestamp
    let text: String?
    let imageUrl: String?
    let audioUrl: String?
    let messageKind: String
    let readUsers: [String] // idを格納
    
    func convertToDic() -> [String: Any] {
        return ["chatId": self.chatId, "senderId": self.senderId, "senderName": self.senderName,
                "sentDate": self.sentDate, "text": self.text, "imageUrl": self.imageUrl, "audioUrl": self.audioUrl,
                "messageKind": self.messageKind, "readUsers": self.readUsers]
    }
    
    // app -> firebase
    init(chatId: String, senderId: String, senderName: String, sentDate: Date, text: String = "",
         imageUrl: String = "", audioUrl: String = "", messageKind: String = "text", readUsers: [String]) {
        self.chatId = chatId
        self.senderId = senderId
        self.senderName = senderName
        self.sentDate = Timestamp(date: sentDate)
        self.messageKind = messageKind
        self.readUsers = readUsers
        self.text = text
        self.imageUrl = imageUrl
        self.audioUrl = audioUrl
    }
    
    // firebase -> app
    // 後でアプリ内で使うデータ構造へ変換する
    init?(data: [String:Any]) {
        guard
            let chatId = data["chatId"] as? String,
            let senderId = data["senderId"] as? String,
            let senderName = data["senderName"] as? String,
            let sentDate = data["sentDate"] as? Timestamp,
            let readUsers = data["readUsers"] as? [String] else { return nil }
        
        self.chatId = chatId
        self.senderId = senderId
        self.senderName = senderName
        self.sentDate = sentDate
        self.readUsers = readUsers
        
        if let text = data["text"] as? String, text != "", !text.isEmpty, text.count != 0 {
            self.text = text
            self.imageUrl = nil
            self.audioUrl = nil
            self.messageKind = "text"
        } else if let imageUrl = data["imageUrl"] as? String, imageUrl != "", !imageUrl.isEmpty, imageUrl.count != 0 {
            self.text = nil
            self.imageUrl = imageUrl
            self.audioUrl = nil
            self.messageKind = "image"
        } else if let audioUrl = data["audioUrl"] as? String, audioUrl != "", !audioUrl.isEmpty, audioUrl.count != 0 {
            self.text = nil
            self.imageUrl = nil
            self.audioUrl = audioUrl
            self.messageKind = "audio"
        } else {
            self.text = nil
            self.imageUrl = nil
            self.audioUrl = nil
            self.messageKind = "text"
        }
    }
    
    // FMessage -> Message
    func convertToMessage() -> Message {
        var messageKind: MessageKind = .text("")
        
        switch self.messageKind {
        case "text":
            messageKind = .text(self.text!)
        case "image":
            // 使う側でFirebaseを叩いて画像を取得するため、imageはこの時点ではnil
            messageKind = .photo(Photo(url:URL(string: self.imageUrl!)!, image: nil))
        case "audio":
            // 使う側でFirebaseを叩いて音声を取得するため、durationはこの時点では0
            messageKind = .audio(Audio(url: URL(string: self.audioUrl!)!, duration: 0))
        default:
            break
        }
        
        // この時点ではmessageIdは何も入れない
        // firebaseのdocumentIdがmessageIdになるため
        return Message(sender: Sender(senderId: self.senderId, displayName: self.senderName), chatId: self.chatId,
                       messageId: "", sentDate: self.sentDate.dateValue(), kind: messageKind, readUsers: self.readUsers)
    }

}
