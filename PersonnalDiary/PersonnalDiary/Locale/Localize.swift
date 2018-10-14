//
//  FuckingLocalize.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/13/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

struct Localize {
    
    static let defaultAppLanguage = "en"
    static let baseBundle = "Base"
    
    static func availableLanguages(_ excludeBase: Bool = true) -> [String] {
        // If excludeBase = true, don't include "Base" in available languages
        
        var availableLanguages = Bundle.main.localizations
        if let indexOfBase = availableLanguages.index(of: baseBundle), excludeBase {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    static func currentLanguage() -> String {
        return defaultLanguage()
    }
    
    static func defaultLanguage() -> String {
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return defaultAppLanguage
        }
        
        let availableLanguages = self.availableLanguages()
        var defaultLanguage = defaultAppLanguage
        
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        return defaultLanguage
    }
}
