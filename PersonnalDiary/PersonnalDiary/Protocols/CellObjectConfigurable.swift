//
//  CellObjectConfigurable.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/12/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

protocol CellObjectConfigurable {
    var cellClass: AnyClass { get }
    var cellNib: UINib { get }
}
