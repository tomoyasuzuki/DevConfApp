//
//  Post.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

final class Posts: Codable {
    let author: User
    let description: String
    let createdAt: Date
    let updatedAt: Date
    
    init(author: User, description: String, createdAt: Date, updatedAt: Date) {
        self.author = author
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
