//
//  TweetViewController.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 05.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var api: APIController!
    var dataSource = [TweetTableViewCellObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupInitialSettings()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
    }

    
    func setupInitialSettings() {
        NetworkManager.getAccessToken { [weak self] (accessToken, errorMessage) in
            if let accessToken = accessToken {
                self?.api = APIController(self, accessToken)
                self?.api.searchTweet(withText: "school 42")
            } else {
                self?.alert(with: errorMessage)
            }
        }
    }
    
    func updateSetting(with text: String) {
        NetworkManager.getAccessToken { [weak self] (accessToken, errorMessage) in
            if let accessToken = accessToken {
                self?.api = APIController(self, accessToken)
                self?.api.searchTweet(withText: text)
            } else {
                self?.alert(with: errorMessage)
            }
        }
    }
    
    func alert(with error: String?) {
        if let error = error {
            let alert = UIAlertController(title: "Notice!", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Notice!", message: "Something went wrong!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: keyboard settings
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension TweetViewController: APITwitterDelegate {
    
    func didTreatTweets(_ tweets: [Tweet]) {
        
        tweets.forEach { (tweet) in
            dataSource.append(TweetTableViewCellObject(tweet.name, tweet.time, tweet.text))
        }
       DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    func didFail(_ error: Error) {
         dataSource = [TweetTableViewCellObject]()
         alert(with: error.localizedDescription)
         tableView.reloadData()
    }
}

extension TweetViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        dataSource = [TweetTableViewCellObject]()
        tableView.reloadData()
        
        if let text = textField.text, text != "" {
            updateSetting(with: text)
        } else {
            updateSetting(with: "school 42")
        }
    }
}
