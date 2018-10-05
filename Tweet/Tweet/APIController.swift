//
//  APIController.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 05.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func didTreatTweets(tweets: [Tweet])
    func didFail(error: NSError)
}

class APIController {
    
    weak var delegate: APITwitterDelegate?
    
    let token: String
    
    init(_ delegate: APITwitterDelegate?, _ token: String) {
        self.delegate = delegate
        self.token = token
    }
}
