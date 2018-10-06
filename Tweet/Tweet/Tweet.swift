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
    let time: String
    let text: String
    
    init(_ name: String, _ time: String, _ tweetDescription: String) {
        self.name = name
        self.time = time
        self.text = tweetDescription
    }
}
