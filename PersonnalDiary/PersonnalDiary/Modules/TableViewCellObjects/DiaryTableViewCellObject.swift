//
//  DiaryTableViewCellObject.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/13/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

class DiaryTableViewCellObject {
    
    var title: String?
    var photo: UIImage?
    var content: String?
    var date: String?

    init(_ title: String?, _ photo: UIImage?, _ content: String?, _ date: String?) {
        self.title = title
        self.photo = photo
        self.content = content
        self.date = date
    }
}

// MARK: - CellObjectConfigurable
extension DiaryTableViewCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return DiaryTableViewCell.self
    }
    
    var cellNib: UINib {
        return UINib(nibName: String(describing: DiaryTableViewCell.self), bundle: nil)
    }
}
