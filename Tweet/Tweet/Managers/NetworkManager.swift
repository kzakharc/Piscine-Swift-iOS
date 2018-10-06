//
//  NetworkManager.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 06.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private static let CUSTOMER_KEY = "5eAL0Yt8Q5XTpIBeOo3qnVVQS"
    private static let CUSTOMER_SECRET = "drqTIsUo4FQReeKXqEEehvTuuKedp7XTIIm2iiIeq5EseSBJ1h"
    
    static func getAccessToken(_ completion: @escaping (_ accessToken: String?, _ errorMessage: String?) -> Void) {
        let encodedData = (CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8)
        let bearer = encodedData!.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        guard let url = URL(string: "https://api.twitter.com/oauth2/token") else { print("Wrong URL"); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            }
            if let data = data {
                if let dictinary = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    completion(dictinary.value(forKey: "access_token") as? String, nil)
                } else {
                    completion(nil, "Error while decode data")
                }
            }
        }
        task.resume()
    }
}
