//
//  Router.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/16.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import Swinject

class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: AuthViewController
        
        container.register(AuthViewController.self) { r in
            let vm = r.resolve(AuthViewModel.self)
            let vc = AuthViewController(viewModel: vm!)
            return vc
        }
        
        // MARK: ProfileSettingViewController
        
        container.register(ProfileSettingViewController.self) { r in
            let vm = r.resolve(ProfileSettingViewModelInterface.self)!
            let vc = ProfileSettingViewController(viewModel: vm)
            return vc
        }
        
    }
}
