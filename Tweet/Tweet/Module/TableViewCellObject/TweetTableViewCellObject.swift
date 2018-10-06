//
//  TweetTableViewCellObject.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 05.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

class TweetTableViewCellObject {
    
    var name = String()
    var date = String()
    var tweetDescription = String()

    init(_ name: String, _ date: String, _ tweetDescription: String) {
        self.name = name
        self.date = date
        self.tweetDescription = tweetDescription
    }
}

// MARK: - CellObjectConfigurable
extension TweetTableViewCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return TweetTableViewCell.self
    }
    
    var cellNib: UINib {
        return UINib(nibName: String(describing: TweetTableViewCell.self), bundle: nil)
    }
}

