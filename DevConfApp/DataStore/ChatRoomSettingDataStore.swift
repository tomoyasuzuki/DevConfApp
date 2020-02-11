//
//  ChatRoomSettingDataStore.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseFirestore

protocol ChatRoomSettingDataStoreInterface {
    func getChatRoomMembers(roomId: String) -> Observable<Result<[[String: Any]], Error>>
    func getChatRoomSetting(roomId: String) -> Observable<Result<[String : Any], Error>>
    func updateChatRoomMembers(roomId: String, data: [String : Any]) -> Observable<Error?>
    func updateChatRoomSetting(roomId: String, data: [String : Any]) -> Observable<Error?>
}

class ChatRoomSettingDataStore: ChatRoomSettingDataStoreInterface {
    let db = Firestore.firestore()
    
    func getChatRoomMembers(roomId: String) -> Observable<Result<[[String : Any]], Error>> {
        return Observable.create { observer in
            let disposables = Disposables.create()
            
            self.db.collection("chatroom").document(roomId).collection("members").getDocuments { snp, err in
                if err != nil || snp == nil {
                    observer.onNext(.failure(err!))
                }
                
                if let snp = snp {
                    var datas: [[String : Any]] = []
                    snp.documents.forEach { snap in
                        datas.append(snap.data())
                    }
                    
                    observer.onNext(.success(datas))
                } else {
                    observer.onNext(.failure(FirebaseDataStoreError.internalError))
                }
            }
            return disposables
        }
    }
    
    func getChatRoomSetting(roomId: String) -> Observable<Result<[String : Any], Error>> {
        return Observable.create { observer in
            let disposables = Disposables.create()
            
            self.db.collection("roomSetting").document(roomId).getDocument { snp, err in
                if err != nil || snp == nil {
                    observer.onNext(.failure(err!))
                }
                
                if let data = snp?.data() {
                    observer.onNext(.success(data))
                } else {
                    observer.onNext(.failure(FirebaseDataStoreError.internalError))
                }
            }
            return disposables
        }
    }
    
    func updateChatRoomMembers(roomId: String, data: [String : Any]) -> Observable<Error?> {
        return Observable.create { observer in
            let disposables = Disposables.create()
            
            self.db.collection("chatroom").document(roomId).collection("members").addDocument(data: data) { err in
                if let err = err {
                    observer.onNext(err)
                } else {
                    observer.onNext(nil)
                }
            }
            return disposables
        }
    }
    
    func updateChatRoomSetting(roomId: String, data: [String : Any]) -> Observable<Error?> {
        return Observable.create { observer in
            let disposables = Disposables.create()
            
            self.db.collection("roomSetting").document(roomId).setData(data) { err in
                if let err = err {
                    observer.onNext(err)
                } else {
                    observer.onNext(nil)
                }
            }
            return disposables
        }
    }
}

