//
//  AuthDataStoreInter.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/17.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Swinject

class DataStoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthDataStoreInterface.self) { _ in
            return AuthDataStore()
        }
        
        container.register(UserDataStoreInterface.self) { _ in
            return UserDataStore()
        }
    }
}
