//
//  CellObjectConfigurable.swift
//  Death Note
//
//  Created by pc166 on 10/3/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import UIKit

protocol CellObjectConfigurable {
    var cellClass: AnyClass { get }
    var cellNib: UINib { get }
}
