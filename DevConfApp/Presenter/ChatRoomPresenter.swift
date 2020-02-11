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
    let reload: Driver<String>
}

struct ChatRoomOutput {
    let getMessages: Driver<[MessageEntity]>
}

protocol ChatRoomPresenterInterface {
    func bind(input: ChatRoomInput) -> ChatRoomOutput
}


class ChatRoomPresenter: ChatRoomPresenterInterface {
    func bind(input: ChatRoomInput) -> ChatRoomOutput {
        <#code#>
    }
}
