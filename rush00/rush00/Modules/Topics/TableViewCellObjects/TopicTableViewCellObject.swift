//
//  TopicTableViewCellObject.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

class TopicTableViewCellObject {
    
    var topicTitle = String()
    var date = String()
    var login = String()
    var topicId = Int()
    
    init(_ topicTitle: String, _ date: String, _ login: String, _ topicID: Int) {
        self.topicTitle = topicTitle
        self.date = date
        self.login = login
        self.topicId = topicID
    }
}

// MARK: - CellObjectConfigurable
extension TopicTableViewCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return TopicTableViewCell.self
    }
    
    var cellNib: UINib {
        return UINib(nibName: String(describing: TopicTableViewCell.self), bundle: nil)
    }
}
