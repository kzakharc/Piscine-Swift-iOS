//
//  CellObjectConfigurable.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

protocol CellObjectConfigurable {
    var cellClass: AnyClass { get }
    var cellNib: UINib { get }
}
