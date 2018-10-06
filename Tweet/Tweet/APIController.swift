//
//  APIController.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 05.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func didTreatTweets(_ tweets: [Tweet])
    func didFail(_ error: Error)
}

class APIController {
    
    weak var delegate: APITwitterDelegate?
    
    let stringURL = "https://api.twitter.com/1.1/search/tweets.json?"
    let token: String
    
    init(_ delegate: APITwitterDelegate?, _ token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func searchTweet(withText text: String) {
        if text.isEmpty { return }
        request(with: text)
    }
    
    private func request(with query: String, count: Int = 100) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = stringURL + "q=\(encodedQuery)&lang=en&count=\(count)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard let `self` = self else {
                return
            }
            guard let data = data else { return }
            let response = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            if let statuses = response.value(forKey: "statuses") as? [[String: Any]] {
                let tweets = self.convertResponse(response: statuses)
                self.delegate?.didTreatTweets(tweets)
            } else {
                guard let error = error else { return }
                self.delegate?.didFail(error)
            }
        }).resume()
    }
    
    private func convertResponse(response statuses: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for status in statuses {
            if let user = status["user"] as? [String: Any] {
                let tweet = Tweet(user["name"] as! String, status["created_at"] as! String, status["text"] as! String)
                tweets.append(tweet)
            }
        }
        return tweets
    }
}
