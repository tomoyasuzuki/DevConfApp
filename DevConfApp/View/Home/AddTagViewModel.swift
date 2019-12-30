//
//  AddTagViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2019/12/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import RxFirebase
import FirebaseFirestore
import FirebaseAuth

class AddTagViewModel {
    let db = Firestore.firestore()
    var tags: [String] = []
    
    init() {
        self.observeTags()
    }
    
    struct Input {
        let textChange: Driver<String>
        let tagSelected: Driver<String>
    }
    
    struct Output {
        let reload: Driver<Void>
        let dismiss: Driver<Void>
    }
    
    func observeTags() {
        db.collection(Const.tag).addSnapshotListener { snp, err in
            guard snp == nil || err != nil  else {
                return
            }
            
            snp?.documentChanges.forEach { [weak self] change in
                let data = change.document.data()
                
                if let tag = data["title"] as? String {
                    self?.tags.append(tag)
                }
            }
        }
    }
}
