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
    var backgroundImageUrl: String?
    let githubUrl: String
    let profession: String
    let tags: [String]
    let introduceText: String
    let works: [Work]
    let messages: [Message]
    let chats: [Chat]
    
    init(userId: String, userName: String, profileImageUrl: String, backgroundImageUrl: String,
         githubUrl: String, profession: String, tags: [String], introduceText: String,
         works: [Work], messages: [Message], chats: [Chat]) {
        self.userId = userId
        self.userName = userName
        self.profileImageUrl = profileImageUrl
        self.backgroundImageUrl = backgroundImageUrl
        self.githubUrl = githubUrl
        self.profession = profession
        self.tags = tags
        self.introduceText = introduceText
        self.works = works
        self.messages = messages
        self.chats = chats
    }
    
    // フィールドのみ辞書型にする.messages, chats, works に関してはサブコレクションとして外から追加する
    func convertToDic() -> [String:Any] {
        var proUrl = ""
        var backUrl = ""
        if let url = self.profileImageUrl {
            proUrl = url
        }
        
        if let url = self.backgroundImageUrl {
            backUrl = url
        }
        
        return ["username": self.userName, "profileImageUrl": proUrl, "backgroundImageUrl": backUrl,
                "githubUrl": self.githubUrl, "profession": self.profession, "tags": self.tags, "introduceText": self.introduceText]
    }
}

struct Work {
    let title: String
    let description: String
    let imageUrl: String?
    
    init(title: String, description: String, imageUrl: String?) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
}
