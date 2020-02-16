//
//  ChatRoomUseCase.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/11.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

class ChatRoomUseCase {
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
    
//    func updateReadUsersCount(currentUserId: String) -> Observable<Error?> {
//        return repository.updateReadUsersCount(roomId: roomId, currentUserId: currentUserId)
//    }
}

