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

class ChatViewController: MessagesViewController {
    var fetchCurrentUser: PublishSubject<Void> = PublishSubject()
    var messageDidChange: PublishSubject<MessageChangeType> = PublishSubject()
    var viewModel = ChatViewModel()
    let disposeBag = DisposeBag()
    
    var chatId = "hogehoge"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signIn(withEmail: "tomoya@docomo.ne.jp", password: "tomoya0121") { result, err in
            self.fetchCurrentUser.onNext(())
        }

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        setupViewModel()
    }
    
    
    func setupViewModel() {
        let input = ChatViewModel.Input(fetchCurrentUser: self.fetchCurrentUser.asDriverWithEmpty(),
                                        sendButtonTapped: self.messageDidChange.asDriverWithEmpty())
        
        let output = self.viewModel.bind(input: input)
        
        output.messageAdded
            .drive(onNext: { _ in
                print("message added")
            }).disposed(by: disposeBag)
        
        output.reloadMessage
            .drive(onNext: { _ in
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom()
            }).disposed(by: disposeBag)
    }
}


extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, MessageCellDelegate, MessageInputBarDelegate {
    func currentSender() -> SenderType {
        // login完了前にこの処理が走ると、currentSender
        guard let currentUser = viewModel.currentUser else { return Sender(senderId: "zLdbM1uPnJM8nb08BZ8Ai6W7NBI3", displayName: "zLdbM1uPnJM8nb08BZ8Ai6W7NBI3")}
        
        return Sender(senderId: currentUser.userId, displayName: currentUser.userName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return viewModel.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return viewModel.messages.count
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        messageInputBar.inputTextView.text = ""
        guard let currentUser = self.viewModel.currentUser else { return }
        
        let message = FMessage(chatId: self.chatId, senderId: currentUser.userId, senderName: currentUser.userName,
                               sentDate: Date(), text: text, imageUrl: "", audioUrl: "", messageKind: "text", seenCount: 0)
        self.messageDidChange.onNext(.added(message.convertToDic()))
    }
    
    // メッセージの色を変更（デフォルトは自分：白、相手：黒）
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }

    // メッセージの背景色を変更している（デフォルトは自分：緑、相手：グレー）
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ?
            UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1) :
            UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }

    // メッセージの枠にしっぽを付ける
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        // 自分の名前は表示しない
        if !isFromCurrentSender(message: message) {
            return NSAttributedString(
                string: message.sender.displayName,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .caption2), .foregroundColor: UIColor.gray])
        } else {
            return nil
        }
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if let message = message as? Message {
            return NSAttributedString(
                string: "既読 \(message.seenCount)",
                attributes: [.font: UIFont.preferredFont(forTextStyle: .caption2), .foregroundColor: UIColor.gray])
        } else {
            return nil
        }
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
}
