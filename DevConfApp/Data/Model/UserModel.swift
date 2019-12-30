//
//  UserEntity.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

struct UserModel {
    let userName: String
    let userId: String
    var profileImageURL: String?
    let githubUrl: String
    var posts: [PostModel]
    var threads: [ThreadModel]
    
    init(userName: String, userId: String, profileImageURL: String? = nil, githubUrl: String, posts: [PostModel] = [], threads: [ThreadModel] = []) {
        self.userName = userName
        self.userId = userId
        self.profileImageURL = profileImageURL
        self.githubUrl = githubUrl
        self.posts = posts
        self.threads = threads
    }
    
    
    init?(data: [String: Any]?) {
        guard let data = data,
            let name = data["userName"] as? String,
            let id = data["userId"] as? String,
            let githubUrl = data["githubUrl"] as? String else { return nil }
        
        self.userName = name
        self.userId = id
        self.githubUrl = githubUrl
        
        self.profileImageURL = nil
        self.posts = []
        self.threads = []
    }
}
