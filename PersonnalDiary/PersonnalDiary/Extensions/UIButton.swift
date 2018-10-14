//
//  UIButton.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/13/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func localize(forKey: String) {
        let localizedString = forKey.localized()
        self.setTitle(localizedString, for: .normal)
    }
}

