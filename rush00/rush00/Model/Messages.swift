//
//  Messages.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

struct Messages: CustomStringConvertible {
    
    let id: Int
    let title: String
    let author: String
    let authorID: Int
    let date: String
    let replBool: Bool
    var replies: [Replies]
    
    public var description: String {
        return "\(id)\n\(title)\n\(author)\n\(date)"
    }
    
    init(_ id: Int, _ title: String, _ author: String, _ authorID: Int, _ date: String, _ replBool: Bool, _ replies: [Replies]) {
        self.id = id
        self.title = title
        self.author = author
        self.date = date
        self.authorID = authorID
        self.replBool = replBool
        self.replies = replies
    }
}

struct Replies: CustomStringConvertible {
    
    let messID: Int
    let replID: Int
    let replTitle: String
    let replAuthor: String
    let replAuthorID: Int
    let replDate: String
    
    public var description: String {
        return "\(replID)\n\(replTitle)\n\(replAuthor)\n\(replDate)"
    }
    
    init(_ messID: Int, _ replID: Int, _ replTitle: String, _ replAuthor: String, _ replAuthorID: Int, _ replDate: String) {
        self.messID = messID
        self.replID = replID
        self.replTitle = replTitle
        self.replAuthor = replAuthor
        self.replAuthorID = replAuthorID
        self.replDate = replDate
    }
}
