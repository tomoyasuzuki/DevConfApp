//
//  CreateNewChatViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/04.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import Firebase

class CreateNewChatViewModel {
    let repo = ChatRepository(userId: "")
    let disposeBag = DisposeBag()
    
    var title: String = ""
    var description: String = ""
    var category: String = ""
    var tag: String = ""
    
    struct Input {
        let chatTitleDidChange: Driver<String>
        let descriptionDidChange: Driver<String>
        let categorySelected: Driver<String>
        let tagSelected: Driver<String>
        let createButtonTapped: Driver<Void>
    }
    
    struct Output {
        let addCompleted: Driver<Void>
    }
    
    func bind(input: Input) -> Output {
        input.chatTitleDidChange.asObservable()
            .subscribe(onNext: { title in
                self.title = title
            }).disposed(by: disposeBag)
        
        input.descriptionDidChange.asObservable()
            .subscribe(onNext: { description in
                self.description = description
            }).disposed(by: disposeBag)
        
        input.categorySelected.asObservable()
            .subscribe(onNext: { category in
                self.category = category
            }).disposed(by: disposeBag)
        
        input.tagSelected.asObservable()
            .subscribe(onNext: { tag in
                self.tag = tag
            }).disposed(by: disposeBag)
        
        let add = input.createButtonTapped.asObservable()
            .flatMap { _  -> Observable<Result<Void, Error>> in
                let chat = Chat(chatId: "", chatTitle: self.title, chatMembers: [], createdAt: Date(),
                                updatedAt: Date(), latestMessage: nil, messages: [], readUsersCount: 0)
                let data = chat.convertToDic()
            return self.repo.createChat(data: data)
            }.void().asDriverWithEmpty()
        
        return Output(addCompleted: add)
    }
}
