//
//  UserDataStore.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/14.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import FirebaseFirestore
import FirebaseStorage
import Foundation

protocol UserDataStoreInterface {
    func fetchCurrentUser(id: String, complition: @escaping ([String : Any]?) -> ())
    func fetchChatRoomMembers(roomId: String, complition: @escaping ([[String : Any]]?) -> ())
    func addNewUser(data: [String : Any], complition: @escaping (Error?) -> ())
    func updateUser(id: String, data: [String : Any], complition: @escaping (Error?) -> ())
    func updateUserProfileImage(id: String, data: Data, complition: @escaping (Error?) -> ())
    func updateUserField(id: String, data: [String: Any], complition: @escaping (Error?) -> ())
}

class UserDataStore: UserDataStoreInterface {
    let db = Firestore.firestore().collection("user")
    let storage = Storage.storage()
    
    func fetchCurrentUser(id: String, complition: @escaping ([String : Any]?) -> ()) {
        self.db.document(id).getDocument { snp, err in
            if err != nil {
                complition(nil)
            } else if let snp = snp, let data = snp.data() {
                complition(data)
            } else {
                complition(nil)
            }
        }
    }
    
    func fetchChatRoomMembers(roomId: String, complition: @escaping ([[String : Any]]?) -> ()) {
        self.db.whereField("belongRooms", arrayContains: roomId).getDocuments { snp, err in
            if err != nil {
                complition(nil)
            } else if let snp = snp {
                var datas: [[String : Any]] = []
                
                snp.documents.forEach { snp in
                    datas.append(snp.data())
                }
                
                complition(datas)
            } else {
                complition(nil)
            }
        }
    }
    
    func addNewUser(data: [String : Any], complition: @escaping (Error?) -> ()) {
        self.db.addDocument(data: data) { err in
            
            if let err = err {
                complition(err)
            } else {
                complition(nil)
            }
        }
    }
    
    func updateUser(id: String, data: [String : Any], complition: @escaping (Error?) -> ()) {
        self.db.document(id).updateData(data) { err in
            if let err = err {
                complition(err)
            } else {
                complition(nil)
            }
        }
    }
    
    func updateUserProfileImage(id: String, data: Data, complition: @escaping (Error?) -> ()) {
        self.storage.reference(withPath: id).putData(data, metadata: nil) { meta,err in
            if let err = err {
                complition(err)
            } else {
                if let path = meta?.path {
                    UserDefaults.standard.set(path, forKey: "profileImageUrl")
                }
                complition(nil)
            }
        }
    }
    
    func updateUserField(id: String, data: [String: Any], complition: @escaping (Error?) -> ()) {
        self.db.document(id).updateData(data) { err in
            if let err = err {
                complition(err)
            } else {
                complition(nil)
            }
        }
    }
}
