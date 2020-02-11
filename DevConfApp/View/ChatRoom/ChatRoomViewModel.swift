//
//  ChatViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/26.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import Firebase

public enum MessageChangeType {
    case added([String:Any])
}


enum MessageError: Error {
    case internalError
    case addError
}


class ChatRoomViewModel {
    var userRepo = UserRepository()
    var messageRepo = MessageRepository(chatId: "hogehoge")
    var disposeBag = DisposeBag()
    var loading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    var currentUser: UserModel? = nil
    var messages: [Message] = []
    
    struct Input {
        let fetchCurrentUser: Driver<Void>
        let sendButtonTapped: Driver<MessageChangeType>
    }
    
    struct Output {
        let messageAdded: Driver<Result<Void, Error>>
        let reloadMessage: Driver<Void>
    }
    
    func bind(input: Input) -> Output {
        // インスタンス生成時（入室時）に既読更新のバッチ処理を走らせる
        self.messageRepo.updateUnreadUsersCount()
            .asObservable()
            .subscribe(onNext: { result in
                switch result {
                case .success(()):
                    print("success")
                case .failure(let err):
                    print("fail: \(err.localizedDescription)")
                }
            }).disposed(by: disposeBag)
        
        input.fetchCurrentUser
            .asObservable()
            .flatMap { [weak self] _ -> Observable<UserModel?> in
                guard let self = self else { return Observable.of(nil)}
                return self.userRepo.currentUserModel
            }
            .subscribe(onNext: { user in
                self.currentUser = user
            }).disposed(by: disposeBag)
        
        let addMessage = input.sendButtonTapped
            .asObservable()
            .flatMap { [weak self] type -> Observable<Result<Void, Error>> in
                guard let self = self else { return Observable.of(.failure(MessageError.addError))}
                switch type {
                case .added(let data):
                    return self.messageRepo.addMessage(data: data)
                }
        }.asDriverWithEmpty()
        
        let reload = self.messageRepo.currentChatMessages
            .do(onNext: { message in
                self.messages = message
                print(self.messages.count)
            })
            .void()
            .asDriverWithEmpty()
        
            
        return Output(messageAdded: addMessage, reloadMessage: reload)
    }
}
