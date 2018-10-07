//
//  MessageTableCellObject.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

class MessageTableCellObject {
    
    var message = String()
    var author = String()
    var date = String()
    var isItMessage = true
    
    init(_ message: String, _ author: String, _ date: String, _ isItMessage: Bool) {
        self.message = message
        self.author = author
        self.date = date
        self.isItMessage = isItMessage
    }
}

// MARK: - CellObjectConfigurable
extension MessageTableCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return MessageTableViewCell.self
    }
    
    var cellNib: UINib {
        return UINib(nibName: String(describing: MessageTableViewCell.self), bundle: nil)
    }
}
