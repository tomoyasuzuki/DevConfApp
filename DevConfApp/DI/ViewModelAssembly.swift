//
//  ViewModelAssembly.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/17.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthViewModel.self) { r in
            let usecase = r.resolve(AuthUseCase.self)!
            let vm = AuthViewModel(authUseCase: usecase)
            return vm
        }
    }
}
