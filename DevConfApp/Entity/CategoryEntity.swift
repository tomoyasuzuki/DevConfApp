//
//  CategoryEntity.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

struct CategoryEntity {
    var categoryId: String
    var categoryTitle: String
    var assignedChats: [String]
    
    init(categoryId: String, categoryTitle: String, assignedChats: [String]) {
        self.categoryId = categoryId
        self.categoryTitle = categoryTitle
        self.assignedChats = assignedChats
    }
}
