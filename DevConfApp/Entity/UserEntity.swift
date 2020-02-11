//
//  UserEntity.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

struct UserEntity {
    var userId: String
    var userName: String
    
    init(userId: String, userName: String) {
        self.userId = userId
        self.userName = userName
    }
}
