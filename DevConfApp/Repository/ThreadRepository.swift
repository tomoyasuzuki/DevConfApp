//
//  ThreadRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxFirebaseFirestore
import FirebaseFirestore
import Result
import RxSwift
import RxCocoa

protocol ThreadRepositoryProtocol {
    func fetchThread(id: String) -> Observable<ThreadModel>
    func observeTherad(userId: String) -> Observable<ThreadModel>
}


final class ThreadRepository: ThreadRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func fetchThread(id: String) -> Observable<ThreadModel> {
        return self.db
            .collection("thread")
            .document(id)
            .rx.getDocument()
            .compactMap { ThreadModel(data: $0.data())}
    }
    
    func observeTherad(userId: String) -> Observable<ThreadModel> {
        
        let userRef = self.db.collection("user").document(userId)
        
        return self.db
            .collection("thread")
            .whereField("userRef", isEqualTo: userRef)
            .rx.listen().map { snp in
                var thread: ThreadModel!
                
                snp.documentChanges.forEach { doc in
                    let data = doc.document.data()
                    
                    if let _thread = ThreadModel(data: data) {
                        thread = _thread
                    }
                }
                
                return thread
        }
    }
}
