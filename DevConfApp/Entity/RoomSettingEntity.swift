//
//  RoomSetting.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

struct RoomSettingEntity {
    var roomId: String
    var notifyOrNot: Bool
    
    init(roomId: String, notifyOrNot: Bool) {
        self.roomId = roomId
        self.notifyOrNot = notifyOrNot
    }
}
