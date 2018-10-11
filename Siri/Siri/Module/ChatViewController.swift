//
//  ChatViewController.swift
//  Siri
//
//  Created by Kateryna Zakharchuk on 10/11/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController, MessageInputBarDelegate {
    
    private var messages: [Message] = []
    
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        let testMessage = Message(user: "bot1", content: "Hi")
        insertNewMessage(testMessage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        
        DispatchQueue.main.async { [weak self] in
            self?.messagesCollectionView.reloadData()
            self?.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        let message = Message(user: "bot", content: inputBar.inputTextView.text)
        insertNewMessage(message)
        
        if text != "" {
            networkManager.obtainLocale(inputBar.inputTextView.text, completion: { [weak self] (answer) in
                DispatchQueue.main.async {
                    let message = Message(user: "bot1", content: answer)
                    self?.insertNewMessage(message)
                }
            })
        }
        inputBar.inputTextView.text = ""
    }
}

extension ChatViewController: MessagesDataSource {
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: "bot", displayName: "bot")
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType,
                                    at indexPath: IndexPath) -> NSAttributedString? {
        
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath,
                    in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath,
                           with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath,
                         in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .blue
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}
