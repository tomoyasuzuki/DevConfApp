//
//  PostRepository.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxFirebaseFirestore
import FirebaseFirestore
import Result
import RxSwift
import RxCocoa

protocol PostRepositoryProtocol {
    func fetchPost(id: String) -> Observable<PostModel>
    func observePost(threadId: String) -> Observable<PostModel>
    func observePost(userId: String) -> Observable<PostModel>
}
 
final class PostRepository: PostRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func fetchPost(id: String) -> Observable<PostModel> {
        return self.db.collection("post")
            .document(id)
            .rx.getDocument()
            .compactMap { PostModel(data: $0.data())}
    }
    
    func fetchPostByTheradRef(threadRef: DocumentReference) -> Observable<PostModel> {
        return Observable.create { observer in
            let disposables = Disposables.create()
            
            self.db.collection("post")
                .whereField("threadRef", isEqualTo: threadRef)
                .getDocuments() { snp, error in
                    if let snp = snp {
                        snp.documentChanges.forEach { doc in
                            let data = doc.document.data()
                            if let post = PostModel(data: data) {
                                observer.onNext(post)
                            }
                        }
                    }
            }
            
            return disposables
        }
    }
    
    func observePost(threadId: String) -> Observable<PostModel> {
        let threadRef = self.db.collection("thread").document(threadId)
        
        return self.db.collection("post")
            .whereField("threadRef", isEqualTo: threadRef)
            .rx.listen().map { snp in
                var post: PostModel!
                
                snp.documentChanges.forEach { doc in
                    let data = doc.document.data()
                    
                    if let _post = PostModel(data: data) {
                        post = _post
                    }
                }
                
                return post
        }
    }
    
    func observePost(userId: String) -> Observable<PostModel> {
        let userRef = self.db.collection("user").document(userId)
        
        return self.db.collection("post")
            .whereField("userRef", isEqualTo: userRef)
            .rx.listen().map { snp in
                var post: PostModel!
                
                snp.documentChanges.forEach { doc in
                    let data = doc.document.data()
                    
                    if let _post = PostModel(data: data) {
                        post = _post
                    }
                }
                
                return post
        }
    }
}
