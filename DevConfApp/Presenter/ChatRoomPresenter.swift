//
//  ChatRoomPresenter.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

struct ChatRoomInput {
    let viewDidLoad: Driver<Void>
    let addMessage: Driver<(String, String, Date, String)>
    let deleteMessage: Driver<String>
}

struct ChatRoomOutput {
    let getMessages: Driver<[MessageModel]>
}

protocol ChatRoomPresenterInterface {
    func bind(input: ChatRoomInput) -> ChatRoomOutput
}


class ChatRoomPresenter: ChatRoomPresenterInterface {
    
    var usecase: ChatRoomUseCase
    
    var messages: [MessageModel] = []
    var currentUser: [UserModel] = []
    
    init(usecase: ChatRoomUseCase) {
        self.usecase = usecase
    }
    
    func bind(input: ChatRoomInput) -> ChatRoomOutput {
        
    }
}
