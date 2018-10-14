//
//  UILabel.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/13/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func localize(forKey: String) {
        self.text = forKey.localized()
    }
}
