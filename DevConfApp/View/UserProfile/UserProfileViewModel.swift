//
//  UserProfileViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/30.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import Firebase

class UserProfileViewModel {
    let userRepo = UserRepository()
    
    struct Input {
        let editButtonTapped: Driver<Void>
    }
    
    struct Output {
        let updateProfile: Driver<Void>
    }
    
    func bind(input: Input) {
        self.userRepo.isLogin
    }
}
