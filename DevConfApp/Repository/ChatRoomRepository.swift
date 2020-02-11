//
//  ChatRoomRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/11.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ChatRoomRepositoryInterface {
    func fetchMessages(roomId: String) -> Observable<Result<[MessageEntity], Error>>
    func addMessage(message: MessageEntity) -> Observable<Error?>
    func deleteMessage(roomId: String, messageId: String) -> Observable<Error?>
    func updateReadUsersCount(roomId: String, currentUserId: String) -> Observable<Error?>
}

class ChatRoomRepository: ChatRoomRepositoryInterface {
    
    var dataStore: ChatRoomDataStoreInterface
    var translator: TranslatorInterface
    
    init(translator: TranslatorInterface, dataStore: ChatRoomDataStoreInterface) {
        self.translator = translator
        self.dataStore = dataStore
    }
    
    func fetchMessages(roomId: String) -> Observable<Result<[MessageEntity], Error>> {
        return dataStore.getMessages(roomId: roomId)
            .map { result in
                switch result {
                case .success(let data):
                    return .success(self.translator.translateMessage(data))
                case .failure(let err):
                    return .failure(err)
                }
        }
    }
    
    func addMessage(message: MessageEntity) -> Observable<Error?> {
        return dataStore.addMessage(data: self.translator.translateMessageToData(message: message))
    }
    
    func deleteMessage(roomId: String, messageId: String) -> Observable<Error?> {
        return dataStore.deleteMessage(roomId: roomId, messageId: messageId)
    }
    
    func updateReadUsersCount(roomId: String, currentUserId: String) -> Observable<Error?> {
        return dataStore.updateReadUsersCount(roomId: roomId, currentUserId: currentUserId)
    }
}
