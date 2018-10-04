//
//  CellRenewable.swift
//  Death Note
//
//  Created by pc166 on 10/3/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import Foundation

protocol CellRenewable {
    func shouldUpdateCell(withObject object: CellObjectConfigurable?)
}
