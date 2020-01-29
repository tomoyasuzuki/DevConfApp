//
//  MessageRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/27.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseFirestore


class MessageRepository {
    let db = Firestore.firestore()
    var chatId = ""
    
    init(chatId: String) {
        self.chatId = chatId
    }
    
    // MARK: currentMessage
    
    var currentChatMessages: Observable<[Message]> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else {
                return disposables
            }
            
            self.db.collection("message").whereField("chatId", isEqualTo: self.chatId).addSnapshotListener { snp, err in
                if err != nil {
                    observer.onNext([])
                    return
                }
                
                var messages = [Message]()
                
                snp!.documents.forEach { doc in
                    let data = doc.data()
                    if let message = FMessage(data: data)?.convertToMessage() {
                        messages.append(message)
                    }
                    messages.sort { $0.sentDate < $1.sentDate }
                }
                
                observer.onNext(messages)
            }
            return disposables
        }
    }
    
    // MARK: addMessage
    
    func addMessage(data: [String: Any]) -> Observable<Result<Void, Error>> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else {
                return disposables
            }
            
            self.db.collection("message").addDocument(data: data) { err in
                if err != nil {
                    observer.onNext(.failure(err!))
                    return
                }
                
                observer.onNext(.success(()))
            }
            
            return disposables
        }
    }
}
