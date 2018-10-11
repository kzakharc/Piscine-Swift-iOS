//
//  Message1.swift
//  Siri
//
//  Created by Kateryna Zakharchuk on 10/11/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    
    let id: String?
    let content: String
    let sentDate: Date
    let sender: Sender
    var messageId: String
    var kind: MessageKind
    
    init(user: String, content: String) {
        sender = Sender(id: user, displayName: "bot")
        self.content = content
        sentDate = Date()
        id = nil
        messageId = content
        kind = .text(content)
    }
}

extension Message: Comparable {
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}
