//
//  NetworkManager.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let uid = "53f0e9b73d56c855487381352b34de42e04888b944cd27363c3553daf8a75dd4"
    static let secret = "90cea9590a8ade8854f09894b51f67480d05250c3cea3316db33e7e6b6632a5f"
    static let backLink = "kzakharc%3A%2F%2Frush00"
    
    static var openUrl: URL?
    static var token: String?
    static var userID: String?
    
    static func obtainToken(_ code: String) {
        let url = "https://api.intra.42.fr/oauth/token"
        let params: String = "?grant_type=authorization_code&client_id=" + uid + "&client_secret=" + secret + "&code=" + code + "&redirect_uri=" + backLink
        let request = NSMutableURLRequest(url: (URL(string : url + params))!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary {
                        if let token = json!["access_token"] as? String {
                            self.token = token
                            self.obtainCurrentUser(token)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    static func obtainCurrentUser(_ token: String) {
        let url = "https://api.intra.42.fr/v2/me?access_token=" + token
        let request = NSMutableURLRequest(url: (URL(string : url))!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary {
                        print("APIUserRequest: id=\(json!["id"]!)")
                        self.userID = String(describing: json!["id"]!)
                        self.obtainTopics()
                    }
                }
            }
        }
        task.resume()
    }
    
    static func obtainTopics() {
        let url = "https://api.intra.42.fr/v2/topics?page=1&per_page=100&access_token=" + self.token!
        let request = NSMutableURLRequest(url: (URL(string : url))!)
        
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as? [NSDictionary] {
                        print(json)
                        var topics: [Topic] = []
                        
                        for forum in json! {
                            let id = forum["id"] as! Int
                            let topicName = forum["name"] as! String
                            let user = forum["author"]! as! NSDictionary
                            let name = user["login"] as! String
                            let userId = String(describing: user["id"]!)
                            let date =  forum["created_at"] as! String
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            let date2 = dateFormatter.date(from: date)
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                            
                            let newDate = dateFormatter.string(from: date2!)
  
                            topics.append(Topic(id, topicName, userId, name, newDate))
                        }
                        
                        DatabaseManager.topics = topics
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setupTopics"), object: nil)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func obtainMessages(_ topicID: Int, completion: @escaping () -> Void) {
        let url = "https://api.intra.42.fr/v2/topics/\(topicID)/messages?access_token=" + token!
        let request = NSMutableURLRequest(url: (URL(string : url))!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as! [NSDictionary] {
                        var messages : [Messages] = []
                        for message in json {
                            let id: Int! = message["id"] as! Int
                            let content: String! = message["content"] as! String
                            let user = message["author"]! as! NSDictionary
                            let userName : String! = user["login"] as! String
                            let userID: Int! = user["id"] as! Int
                            let date: String! =  message["created_at"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            let date2 = dateFormatter.date(from: date!)
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                            let newDate = dateFormatter.string(from: date2!)
                            
                            var replies : [Replies] = []
                            var repl: Bool = false
                            if message["replies"] != nil {
                                repl = true
                                for reply in message["replies"] as! [[String : Any]] {
                                    let messID = id as Int
                                    let replID = reply["id"] as! Int
                                    let replTitle = reply["content"] as! String
                                    let replAuthorArr = reply["author"]! as! NSDictionary
                                    let replAuthorName = replAuthorArr["login"] as! String
                                    let replAuthorID = replAuthorArr["id"] as! Int
                                    let replDate = reply["created_at"] as! String
                                    
                                    replies.append(Replies(messID, replID, replTitle, replAuthorName, replAuthorID, replDate))
                                }
                            }
                            messages.append(Messages(id, content, userName, userID, newDate, repl, replies))
                            DatabaseManager.messages = messages
                            completion()
                        }
                        print(messages)
                    }
                }
            }
        }
        task.resume()
    }
}
