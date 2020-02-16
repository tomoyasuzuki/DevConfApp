//
//  RepositoryAssembly.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/17.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Swinject

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthRepositoryInterface.self) { r in
            let repository = AuthRepository(datastore: r.resolve(AuthDataStoreInterface.self)!,
                                            translator: r.resolve(TranslatorInterface.self)!)
            return repository
        }
    }
}
