//
//  MainCollectionViewCellObject.swift
//  APM
//
//  Created by pc166 on 10/4/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import Foundation
import UIKit

class MainCollectionViewCellObject {
    
    var url: URL?
    
    init(_ url: URL?) {
        self.url = url
    }
}

// MARK: - CellObjectConfigurable
extension MainCollectionViewCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return MainCollectionViewCell.self
    }
    
    var cellNib: UINib {
        return UINib(nibName: String(describing: MainCollectionViewCell.self), bundle: nil)
    }
}
