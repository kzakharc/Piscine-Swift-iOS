//
//  CellRenewable.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/12/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

protocol CellRenewable {
    func shouldUpdateCell(withObject object: CellObjectConfigurable?)
}
