
//
//  Moel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import FirebaseFirestore

final class ThreadModel {
    let threadId: String
    let title: String
    let createdAt: String
    let updatedAt: String
    let tags: [String]
    let isActive: Bool
    var clippingUsers: [UserModel]
    var posts: [PostModel]

    init(threadId: String, title: String, createdAt: String, updatedAt: String, tags: [String] = [], isActive: Bool, clippingUsers: [UserModel] = [], posts: [PostModel] = []) {
        self.threadId = threadId
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tags = tags
        self.isActive = isActive
        self.clippingUsers = clippingUsers
        self.posts = posts
    }
    
    
    init?(data: [String: Any]?) {
        guard let data = data,
            let threadId = data["threadId"] as? String,
            let title = data["title"] as? String,
            let createdAt = data["createdAt"] as? String,
            let updatedAt = data["updatedAt"] as? String,
            let isActive = data["isActive"] as? Bool,
            let tags = data["tags"] as? [String] else
        {
                return nil
                
        }
        
        self.threadId = threadId
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tags = tags
        self.isActive = isActive
        
        self.posts = []
        self.clippingUsers = []
        
    }
    
    func convertToDictionary() -> [String: Any] {
        let data: [String: Any] = ["title": self.title,
                                   "createdAt": self.createdAt,
                                   "updatedAt": self.updatedAt,
                                   "tags": self.tags,
                                   "isActive": self.isActive,
                                   "clippingUsers": self.clippingUsers,
                                   "posts": self.posts]
        
        return data
    }
}
