//
//  TagModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

struct TagModel {
    let title: String
    let relatedThreads: [ThreadModel]
    
    init(title: String, relatedThreads: [ThreadModel] = []) {
        self.title = title
        self.relatedThreads = relatedThreads
    }
    
    init?(data: [String: Any]) {
        guard let title = data[Const.title] as? String else {
            return nil
        }
        
        self.title = title
        
        // relatedThreadsを初期化時に設定できるケースはない
        // 再度Firebase から取得する必要がある
        self.relatedThreads = []
    }
}
