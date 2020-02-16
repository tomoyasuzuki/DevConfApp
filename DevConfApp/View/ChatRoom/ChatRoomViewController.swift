//
//  ChatViewController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/01/26.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import Firebase
import MessageKit
import InputBarAccessoryView

class ChatRoomViewController: MessagesViewController {
//    var messages: [MessageModel] = []
//    var currentUser: UserEntity?
//
//    let disposeBag = DisposeBag()
//
//    var notifyViewDidLoad: PublishSubject<Void> = PublishSubject()
//    var addMessage: PublishSubject<(String, String, Date, String)> = PublishSubject()
//    var deleteMessage: PublishSubject<String> = PublishSubject()
//
//    var presenter: Chatroomviewmo?
//
//    var chatId: String
//
//    init(chatId: String) {
//        self.chatId = chatId
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//        messageInputBar.delegate = self
//
//        setupPresenter()
//    }
//
//    private func setupPresenter() {
//        let input = ChatRoomInput(viewDidLoad: notifyViewDidLoad.asDriverWithEmpty(),
//                                  addMessage: addMessage.asDriverWithEmpty(),
//                                  deleteMessage: deleteMessage.asDriverWithEmpty())
//
//        let output = presenter!.bind(input: input)
//
//        output.getMessages.asObservable()
//            .subscribe(onNext: { messages in
//                self.messages = messages
//            }).disposed(by: disposeBag)
//    }
//}
//
//
//extension ChatRoomViewController: MessagesDataSource, MessagesLayoutDelegate {
//    func currentSender() -> SenderType {
//        return Sender(senderId: currentUser?.userId ?? "none", displayName: currentUser?.userName ?? "none")
//    }
//
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        return messages[indexPath.section]
//    }
//
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        return messages.count
//    }
//
//    // メッセージの色を変更（デフォルトは自分：白、相手：黒）
//    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        return isFromCurrentSender(message: message) ? .white : .darkText
//    }
//
//    // メッセージの背景色を変更している（デフォルトは自分：緑、相手：グレー）
//    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        return isFromCurrentSender(message: message) ?
//            Const.color.vividLightBlue :
//            UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
//    }
}

//extension ChatRoomViewController: MessagesDisplayDelegate, MessageCellDelegate, MessageInputBarDelegate {
//    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//        messageInputBar.inputTextView.text = ""
//        // 必要な値だけをPresenterに渡し、変換はPresenter側で行う
//        let message = (currentUser!.userId, currentUser!.userName, Date(), text)
//        addMessage.onNext(message)
//    }
//
//    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
//        return .bubble
//    }
//
//    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//        // 自分の名前は表示しない
//        if !isFromCurrentSender(message: message) {
//            return NSAttributedString(
//                string: message.sender.displayName,
//            attributes: [.font: UIFont.preferredFont(forTextStyle: .caption2), .foregroundColor: UIColor.gray])
//        } else {
//            return nil
//        }
//    }
//
//    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//        if let message = message as? MessageModel {
//            if message.readUsers.count == 0 {
//                return NSAttributedString(
//                string: "未読",
//                attributes: [.font: UIFont.preferredFont(forTextStyle: .caption2), .foregroundColor: UIColor.gray])
//            } else {
//                return NSAttributedString(
//                    string: "既読 \(message.readUsers.count)",
//                attributes: [.font: UIFont.preferredFont(forTextStyle: .caption2), .foregroundColor: UIColor.gray])
//            }
//        } else {
//            return nil
//        }
//    }
//
//    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        if isFromCurrentSender(message: message) {
//            return 0
//        } else {
//            return 16
//        }
//    }
//
//    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        return 16
//    }
//}
