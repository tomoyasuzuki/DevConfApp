//
//  UseCaseAssembly.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/17.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import Swinject

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthUseCase.self) { r in
            let repository = r.resolve(AuthRepositoryInterface.self)!
            return AuthUseCase(repository: repository)
        }
        
        container.register(UserUseCase.self) { r in
            let repository = r.resolve(UserRepositoryInterface.self)!
            return UserUseCase(repository: repository)
        }
    }
}
