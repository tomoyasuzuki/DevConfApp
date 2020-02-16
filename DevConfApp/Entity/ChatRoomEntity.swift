//
//  ChatRoomEntity.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

struct ChatRoomEntity {
    var roomId: String
    var roomTitle: String
    var category: String
    var tags: [String]
    
    init(roomId: String, roomTitle: String, category: String, tags: [String]) {
        self.roomId = roomId
        self.roomTitle = roomTitle
        self.category = category
        self.tags = tags
    }
}
