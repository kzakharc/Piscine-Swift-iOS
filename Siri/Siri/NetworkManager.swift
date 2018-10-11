//
//  NetworkManager.swift
//  Siri
//
//  Created by Kateryna Zakharchuk on 10/10/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import RecastAI
import ForecastIO

class NetworkManager {
    
    private let darkSkySecretKey = "06f65ccd16c98c7b81d4a545e608a437"
    private let botToken = "cede957cd5d0c9d54df07c6c02e3a9c5"
    
    private var bot: RecastAIClient?
    private var client: DarkSkyClient?
    
    init() {
        bot = RecastAIClient(token : botToken, language: "en")
        client = DarkSkyClient(apiKey: darkSkySecretKey)
    }
    
    func obtainLocale(_ text: String, completion: @escaping ((String) -> Void)) {
        bot?.textRequest(text, successHandler: { [weak self] (response) in
            print("✅ \(response) ✅")
            if let location = response.all(entity: "location") {
                if let lat = location[0]["lat"] as? Double, let lng = location[0]["lng"] as? Double,
                    let raw = location[0]["raw"] as? String {
                    self?.getWeather(lat, lng, raw, completion: { (response) in
                        completion(response)
                    })
                } else {
                     completion("Information not found, try later")
                }
            } else {
                completion("Information not found, try later")
            }
        }, failureHandle: { (error) in
            print("🛑 \(error) 🛑")
             completion("Information not found, try later")
        })
    }
    
    func getWeather(_ lat: Double, _ lng: Double, _ town: String, completion: @escaping ((String) -> Void)) {
        client?.getForecast(latitude: lat, longitude: lng) { result in
            switch result {
            case .success(let currentForecast, _):
                if let summary = currentForecast.currently?.summary {
                    let answerLabel = "In " + town + " the wheather is " + summary
                    completion(answerLabel)
                } else {
                    completion("Information not found, try later")
                }
            case .failure( _):
                 completion("Information not found, try later")
            }
        }
    }
}
