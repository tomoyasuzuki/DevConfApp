//
//  Enums.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

// MARK: Error

enum FirebaseDataStoreError: Error {
    case internalError
}

enum MessageChangeType {
    case add
    case delete
}
