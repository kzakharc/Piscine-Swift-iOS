//
//  String.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/13/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

extension String {
    
    func localized(using tableName: String? = nil, in bundle: Bundle? = nil) -> String {
        let bundle: Bundle = bundle ?? .main
        if let path = bundle.path(forResource: Localize.currentLanguage(), ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        else if let path = bundle.path(forResource: Localize.baseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        return self
    }
}
