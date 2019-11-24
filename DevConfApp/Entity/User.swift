//
//  UserEntity.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

final class User: Codable {
    let name: String
    let id: String
    let profileImageURL: String?
    let posts: [Post]
    let threads: [Thread]
    
    init(name: String, id: String, profileImageURL: String? = nil, posts: [Post] = [], threads: [Thread] = []) {
        self.name = name
        self.id = id
        self.profileImageURL = profileImageURL
        self.posts = posts
        self.threads = threads
    }
}
