//
//  TagEntity.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/10.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Foundation

struct TagEntity {
    var id: String
    let title: String
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    
    func convertToDic() -> [String : Any] {
        return ["id": self.id, "title": self.title]
    }
}
