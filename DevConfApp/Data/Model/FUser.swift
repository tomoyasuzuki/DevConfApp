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
    var backgroundImageUrl: String?
    let githubUrl: String
    let profession: String
    let tags: [String]
    let introduceText: String
    let works: [Work] // workはFirebaseに保存する型と使いまわす型が同じ
    let messages: [FMessage]
    let chats: [FChat]
    
    
    init?(data: [String:Any]) {
        guard let username = data["username"] as? String ,
            let profileImageUrl = data["profileImageUrl"] as? String ,
            let backgroundImageUrl = data["backgroundImageUrl"] as? String,
            let githubUrl = data["githubUrl"] as? String,
            let profession = data["profession"] as? String,
            let tags = data["tags"] as? [String],
            let introduceText = data["introduceText"] as? String else {
                return nil
        }
        
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.backgroundImageUrl = backgroundImageUrl
        self.githubUrl = githubUrl
        self.profession = profession
        self.tags = tags
        self.introduceText = introduceText
        
        self.works = []
        self.messages = []
        self.chats = []
    }
    
    
    func convertToUserModel() -> UserModel {
        var proUrl = ""
        var backUrl = ""
        let messages = self.messages.map { $0.convertToMessage() }
        let chats = self.chats.map { $0.convertToChat() }
        
        if let url = self.profileImageUrl {
            proUrl = url
        }
        
        if let url = self.backgroundImageUrl {
            backUrl = url
        }
        
        return UserModel(userId: "", userName: self.username, profileImageUrl: proUrl, backgroundImageUrl: backUrl,
                         githubUrl: self.githubUrl, profession: self.profession, tags: self.tags, introduceText: self.introduceText,
                         works: self.works, messages: messages, chats: chats)
    }
}
