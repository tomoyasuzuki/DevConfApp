//
//  ChatRoomDataStore.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/11.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import FirebaseFirestore
import RxSwift
import RxCocoa

protocol ChatRoomDataStoreInterface {
    func getMessages(roomId: String) -> Observable<Result<[[String: Any]], Error>>
    func addMessage(data: [String : Any]) -> Observable<Error?>
    func deleteMessage(roomId: String?, messageId: String) -> Observable<Error?>
}

class ChatRoomDataStore: ChatRoomDataStoreInterface {
    let db = Firestore.firestore()
    
    func getMessages(roomId: String) -> Observable<Result<[[String : Any]], Error>> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else {
                return disposables
            }
            
            self.db.collection("message")
                .whereField("roomId", isEqualTo: roomId)
                .addSnapshotListener { snp, err in
                    if err != nil || snp == nil {
                        observer.onNext(.failure(FirebaseDataStoreError.internalError))
                    }
                    
                    var dataArray: [[String : Any]] = []
                    snp!.documents.forEach { doc in
                        dataArray.append(doc.data())
                    }
                    
                    observer.onNext(.success(dataArray))
            }
            return disposables
        }
    }
    
    func addMessage(data: [String : Any]) -> Observable<Error?> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else {
                return disposables
            }
            
            self.db.collection("message").addDocument(data: data) { err in
                if err != nil {
                    observer.onNext(FirebaseDataStoreError.internalError)
                    return
                }
                
                observer.onNext(nil)
            }
            
            return disposables
        }
    }
    
    func deleteMessage(roomId: String? = nil, messageId: String) -> Observable<Error?> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else {
                return disposables
            }
            
            self.db.collection("message").document(messageId).delete() { err in
                if err != nil {
                    observer.onNext(FirebaseDataStoreError.internalError)
                    return
                }
                
                observer.onNext(nil)
            }
            
            return disposables
        }
    }
    
//    func updateReadUsersCount(roomId: String, currentUserId: String) -> Observable<Error?> {
//        return Observable.create { [weak self] observer in
//            let disposables = Disposables.create()
//            guard let self = self else { return disposables }
//
//            self.db.collection("message").whereField("roomId", isEqualTo: roomId).getDocuments { snp, err in
//                if err != nil {
//                    observer.onNext(FirebaseDataStoreError.internalError)
//                    return
//                }
//
//                var unreadMesssages: [MessageEntity] = []
//
//                snp!.documents.forEach { snapshot in
//                    let data = snapshot.data()
//                    let message = FMessage(data: data)
//
//                    if var message = message {
//                        message.messageId = snapshot.documentID
//
//                        if  message.senderId != currentUserId, !message.readUsers.contains(currentUserId) {
//                            message.readUsers.append(currentUserId)
//                            unreadMesssages.append(message)
//                        }
//                    }
//                }
//
//                self.batchReadUsers(messages: unreadMesssages, currentUserId: currentUserId) { err in
//                    if let err = err {
//                        observer.onNext(err)
//                    } else {
//                        observer.onNext(nil)
//                    }
//                }
//            }
//            return disposables
//        }
//    }
//
//    // 既読管理用のバッチ処理
//    private func batchReadUsers(messages: [FMessage], currentUserId: String, complition: @escaping (Error?) -> ()) {
//        guard !messages.isEmpty else { return }
//
//        let batch = db.batch()
//
//        for message in messages {
//            batch.updateData(["readUsers": FieldValue.arrayUnion([currentUserId])],
//                             forDocument: db.collection("message").document(message.messageId))
//        }
//
//        batch.commit { err in
//            if let err = err {
//                complition(err)
//            } else {
//                complition(nil)
//            }
//        }
//    }
}
