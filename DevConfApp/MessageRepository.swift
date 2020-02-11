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
    var userId = ""
    
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
                }
                
                messages.sort { $0.sentDate < $1.sentDate }
                
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
    
    func updateUnreadUsersCount() -> Observable<Result<Void, Error>> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else { return disposables }
            
            self.db.collection("message").whereField("chatId", isEqualTo: self.chatId).getDocuments { snp, err in
                if err != nil {
                    observer.onNext(.failure(err!))
                    return
                }
                
                var unreadMesssages: [FMessage] = []
                
                snp!.documents.forEach { snapshot in
                    let data = snapshot.data()
                    let message = FMessage(data: data)
                    
                    if var message = message {
                        message.messageId = snapshot.documentID
                        
                        if  message.senderId != self.userId, !message.readUsers.contains(self.userId) {
                            message.readUsers.append(self.userId)
                            unreadMesssages.append(message)
                        }
                    }
                }
                
                self.batchReadUsers(messages: unreadMesssages) { err in
                    if let err = err {
                        observer.onNext(.failure(err))
                    } else {
                        observer.onNext(.success(()))
                    }
                }
            }
            return disposables
        }
    }
    
    // 既読管理用のバッチ処理
    private func batchReadUsers(messages: [FMessage], complition: @escaping (Error?) -> ()) {
        guard !messages.isEmpty else { return }
        
        let batch = db.batch()
        
        for message in messages {
            batch.updateData(["readUsers": FieldValue.arrayUnion([self.userId])],
                             forDocument: db.collection("message").document(message.messageId))
        }
        
        batch.commit { err in
            if let err = err {
                complition(err)
            } else {
                complition(nil)
            }
        }
    }
}
