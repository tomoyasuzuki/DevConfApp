//
//  ChatRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/03.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import FirebaseFirestore

class ChatRepository {
    // 既読or未読はmessageが持つ
    // messageにreadUsersを持たせる
    // 新しく既読が増えた場合には全てのchatに既読を走らせる
    let db = Firestore.firestore()
    var userId = ""
    
    init(userId: String) {
        self.userId = userId
    }
    
    func createChat(data: [String: Any]) -> Observable<Result<Void, Error>> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else { return disposables }
            
            self.db.collection("chat").addDocument(data: data) { err in
                if let err = err {
                    observer.onNext(.failure(err))
                } else {
                    observer.onNext(.success(()))
                }
            }
            return disposables
        }
    }
    
    var currentChats: Observable<[Chat]> {
        return Observable.create { [weak self] observer in
            let disposables = Disposables.create()
            guard let self = self else {
                return disposables
            }
            
            self.db.collection("users").document(self.userId).collection("chats").addSnapshotListener { snp, err in
                if err != nil {
                    observer.onNext([])
                    return
                }
                
                var chats = [Chat]()
                
                snp!.documents.forEach { doc in
                    let data = doc.data()
                    if let chat = FChat(data: data)?.convertToChat() {
                        chats.append(chat)
                    }
                    chats.sort { $0.latestMessage!.sentDate < $1.latestMessage!.sentDate }
                }
                
                observer.onNext(chats)
            }
            return disposables
        }
    }
}
