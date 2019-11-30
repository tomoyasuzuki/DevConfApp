
//
//  Moel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

enum ThreadStatus {
    case active
    case stopped
}

final class ThreadModel {
    let title: String
    let threadId: String
    let createdAt: String
    let updatedAt: String
    let tags: [String]?
    let status: ThreadStatus
    var clippingUsers: [UserModel]?
    var clippingUserCount: Int
    var posts: [PostModel]?
    var postCount: Int

    init(title: String, threadId: String, createdAt: String, updatedAt: String, tags: [String], status: ThreadStatus, clippingUsers: [UserModel],clippingUsreCount: Int, posts: [PostModel], postCount: Int){
        self.title = title
        self.threadId = threadId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tags = tags
        self.status = status
        self.clippingUsers = clippingUsers
        self.clippingUserCount = clippingUsreCount
        self.posts = posts
        self.postCount = postCount
    }
    
    
    init?(data: [String: Any]?) {
        guard let data = data,
            let title = data["title"] as? String,
            let threadId = data["threadId"] as? String,
            let createdAt = data["createdAt"] as? String,
            let updatedAt = data["updatedAt"] as? String,
            let status = data["status"] as? String,
            let clippingUserCount = data["clippingUserCount"] as? Int,
            let postCount = data["postCount"] as? Int else { return nil}
        
        self.title = title
        self.threadId = threadId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.clippingUserCount = clippingUserCount
        self.postCount = postCount
        
        // これらはthreadIdを元に再度fetchする必要がある
        self.clippingUsers = nil
        self.posts = nil
        self.tags = nil
        
        if status == "active" {
            self.status = .active
        } else {
            self.status = .stopped
        }
    }
}
