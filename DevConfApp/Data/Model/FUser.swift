//
//  FUser.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/27.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Firebase

struct FUser {
    let username: String
    var profileImageUrl: String?
    let githubUrl: String
    let messages: [FMessage]
    let chats: [FChat]
    
    
    init?(data: [String:Any]) {
        guard let username = data["username"] as? String ,
            let profileImageUrl = data["profileImageUrl"] as? String ,
            let githubUrl = data["githubUrl"] as? String else {
                return nil
        }
        
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.githubUrl = githubUrl
        
        self.messages = []
        self.chats = []
    }
    
    
    func convertToUserModel() -> UserModel {
        var proUrl = ""
        let messages = self.messages.map { $0.convertToMessage() }
        let chats = self.chats.map { $0.convertToChat() }
        
        if let url = self.profileImageUrl {
            proUrl = url
        }
        
        return UserModel(userId: "", userName: self.username, profileImageUrl: proUrl,
                         githubUrl: self.githubUrl, messages: messages, chats: chats)
    }
}
