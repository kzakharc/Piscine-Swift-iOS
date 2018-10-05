//
//  Tweet.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 05.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    
    var description: String {
        return "\(name): \(text)"
    }

    let name: String
    let text : String
    
    
}
