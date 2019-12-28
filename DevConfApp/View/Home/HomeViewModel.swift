//
//  ViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/11/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseFirestore
import FirebaseAuth

final class HomeViewModel {
    let db = Firestore.firestore()
    var threads = [ThreadModel]()
    
    init() {
        
    }
    
//    func observeThread() {
//        db.collection(Const.thread).addSnapshotListener { snp, err in
//            guard snp == nil || err != nil  else {
//                return
//            }
//
//            snp?.documentChanges.forEach{ snp in
//                let data = snp.document.data()
//
//                if let thread = ThreadModel(data: data) {
//                    self.threads.append(thread)
//                }
//            }
//        }
//    }
    
    func addThread(thread: ThreadModel) {
        
    }
}
