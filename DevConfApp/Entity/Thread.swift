//
//  Thread.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/24.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import Foundation

final class Thread: Codable {
    let title: String
    let startDate: Date
    let tags: [String]
    let postsCount: Int
    
    init(title: String, startDate: Date, tags: [String], postsCount: Int) {
        self.title = title
        self.startDate = startDate
        self.tags = tags
        self.postsCount = postsCount
    }
}
