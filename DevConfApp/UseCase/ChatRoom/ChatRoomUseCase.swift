//
//  ChatRoomUseCase.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/11.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ChatRoomUsecaseInterface {
    func getMessages() -> Observable<Result<[MessageEntity], Error>>
    func addMessage(message: MessageEntity) -> Observable<Error?>
    func deleteMessage(massageId: String) -> Observable<Error?>
    func updateReadUsersCount(currentUserId: String) -> Observable<Error?>
}

class ChatRoomUseCase: ChatRoomUsecaseInterface {
    // MARK: Repository
    
    var repository: ChatRoomRepositoryInterface
    
    // MARK: Property
    
    var roomId: String!
    
    init(roomId: String, repository: ChatRoomRepositoryInterface) {
        self.roomId = roomId
        self.repository = repository
    }
    
    func getMessages() -> Observable<Result<[MessageEntity], Error>> {
        return repository.fetchMessages(roomId: roomId)
    }
    
    func addMessage(message: MessageEntity) -> Observable<Error?> {
        return repository.addMessage(message: message)
    }
    
    func deleteMessage(massageId messageId: String) -> Observable<Error?> {
        return repository.deleteMessage(roomId: roomId, messageId: messageId)
    }
    
    func updateReadUsersCount(currentUserId: String) -> Observable<Error?> {
        return repository.updateReadUsersCount(roomId: roomId, currentUserId: currentUserId)
    }
}

