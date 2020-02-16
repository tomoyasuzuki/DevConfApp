//
//  TagEntity.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

struct TagEntity {
    var tagId: String
    var tagTitle: String
    var assignedChats: [String]
    
    init(tagId: String, tagTitle: String, assignedChats: [String]) {
        self.tagId = tagId
        self.tagTitle = tagTitle
        self.assignedChats = assignedChats
    }
}
