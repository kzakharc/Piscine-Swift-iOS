//
//  CellRenewable.swift
//  Kanto
//
//  Created by Kateryna Zakharchuk on 08.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

protocol CellRenewable {
    func shouldUpdateCell(withObject object: CellObjectConfigurable?)
}
