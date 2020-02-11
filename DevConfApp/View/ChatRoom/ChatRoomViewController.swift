//
//  ChatViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/26.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth
import Firebase
import MessageKit
import InputBarAccessoryView

class ChatRoomViewController: MessagesViewController {
    var messages: [MessageEntity] = []
    var currentUser: UserEntity?
    
    let disposeBag = DisposeBag()
    
    var notifyViewDidLoad: PublishSubject<Void> = PublishSubject()
    var reload: PublishSubject<String> = PublishSubject()
    
    var presenter: ChatRoomPresenterInterface?
    
    var chatId: String
    
    init(chatId: String) {
        self.chatId = chatId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupPresenter() {
        let input = ChatRoomInput(viewDidLoad: notifyViewDidLoad.asDriverWithEmpty(),
                                  reload: reload.asDriverWithEmpty())
        
        let output = presenter!.bind(input: input)
        
        output.getMessages.asObservable()
            .subscribe(onNext: { messages in
                self.messages = messages
            }).disposed(by: disposeBag)
    }
    
    func autoLayout() {
        
    }
}
