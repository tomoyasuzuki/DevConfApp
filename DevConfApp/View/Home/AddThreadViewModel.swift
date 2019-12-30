//
//  AddThreadViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import RxFirebase
import FirebaseFirestore
import FirebaseAuth
import Result

class AddThreadViewModel {
    let db = Firestore.firestore()
    
    func addThread(_ thread: ThreadModel) -> Observable<Void> {
        let data: [String: Any] = thread.convertToDictionary()
        
        return db.collection(Const.thread).rx.addDocument(data: data).void()
    }
}
