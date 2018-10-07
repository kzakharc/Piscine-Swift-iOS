//
//  Topic.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

struct Topic: CustomStringConvertible {
    
    var id: Int
    var name: String
    var authorId: String
    var authorLogin: String
    var date: String
    
    var description: String {
        return "\(id)\n\(name)\n\(authorId)\n\(authorLogin)\n\(date)"
    }
    
    init(_ id: Int, _ name: String, _ authorId: String, _ authorLogin: String, _ date: String) {
        self.id = id
        self.name = name
        self.authorId = authorId
        self.authorLogin = authorLogin
        self.date = date
    }
}
