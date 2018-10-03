//
//  DeadPeopleTableCellObject.swift
//  Death Note
//
//  Created by pc166 on 10/3/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import Foundation
import UIKit

class DeadPeopleTableCellObject {
    
    var name = String()
    var time = String()
    var description = String()
    
    init(_ name: String, _ time: String, _ description: String) {
        self.name = name
        self.time = time
        self.description = description
    }
}

// MARK: - CellObjectConfigurable
extension DeadPeopleTableCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return DeadPeopleTableViewCell.self
    }
    
    var cellNib: UINib {
        return UINib(nibName: String(describing: DeadPeopleTableViewCell.self), bundle: nil)
    }
}
