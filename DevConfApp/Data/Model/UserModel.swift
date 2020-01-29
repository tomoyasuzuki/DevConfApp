//
//  UserModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/27.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Foundation

struct UserModel {
    var userId: String
    let userName: String
    var profileImageUrl: String?
    let githubUrl: String
    let messages: [Message]
    let chats: [Chat]
    
    init(userId: String, userName: String, profileImageUrl: String, githubUrl: String, messages: [Message], chats: [Chat]) {
        self.userId = userId
        self.userName = userName
        self.profileImageUrl = profileImageUrl
        self.githubUrl = githubUrl
        self.messages = messages
        self.chats = chats
    }
    
    // フィールドのみ辞書型にする.messages, chats に関してはサブコレクションとして外から追加する
    func convertToDic() -> [String:Any] {
        var url = ""
        if let proUrl = self.profileImageUrl {
            url = proUrl
        }
        
        return ["username": self.userName, "profileImageUrl": url, "githubUrl": self.githubUrl]
    }
}
