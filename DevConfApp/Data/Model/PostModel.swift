//
//  Post.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

final class PostModel {
    let author: UserModel?
    let thread: ThreadModel?
    let id: String
    let description: String
    let createdAt: String
    let updatedAt: String
    
    init(author: UserModel, thread: ThreadModel, id: String,description: String, createdAt: String, updatedAt: String) {
        self.author = author
        self.thread = thread
        self.id = id
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init?(data: [String: Any]?) {
        guard let data = data,
            let id = data["id"] as? String,
            let description = data["description"] as? String,
            let createdAt = data["createdAt"] as? String,
            let updatedAt = data["updatedAt"] as? String else {
                return nil
        }
        
        self.id = id
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.author = nil
        self.thread = nil
    }
}
