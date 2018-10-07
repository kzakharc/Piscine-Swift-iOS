//
//  MainViewController.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 06.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let openUrl = #selector(MainViewController.openUrl)
    static let setupTopics = #selector(MainViewController.setupTopics)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let link = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=53f0e9b73d56c855487381352b34de42e04888b944cd27363c3553daf8a75dd4&redirect_uri=kzakharc%3A%2F%2Frush00&response_type=code")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearData()
        
        setupInitialSettings()
        
        NotificationCenter.default.addObserver(self, selector: .openUrl, name: Notification.Name("openUrl"), object: nil)
        NotificationCenter.default.addObserver(self, selector: .setupTopics, name: Notification.Name("setupTopics"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("openUrl"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("setupTopics"), object: nil)
    }
    
    @IBAction func touchLogin(_ sender: UIButton) {
        UIApplication.shared.open(link!, options: [:], completionHandler: nil)
    }
    
    @objc func openUrl() {
        if let url = NetworkManager.openUrl {
            let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
            for queryItem in (components?.queryItems!)! {
                if queryItem.name == "code" {
                    if let code = queryItem.value {
                        loadingView.alpha = 0
                        loadingView.isHidden = false
                        activityIndicator.isHidden = false
                        UIView.animate(withDuration: 1, animations: { [weak self] in
                            self?.loadingView.alpha = 0.6
                        })
                        
                        NetworkManager.obtainToken(code)
                    }
                } else {
                    let alert = UIAlertController(title: "Notice!", message: "Access denied!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func setupTopics() {
        DispatchQueue.main.async { [weak self] in
             self?.performSegue(withIdentifier: "TopicsViewController", sender: self)
            NotificationCenter.default.removeObserver(self as Any, name: Notification.Name("setupTopics"), object: nil)
        }
    }
    
    func setupInitialSettings() {
        loadingView.isHidden = true
        activityIndicator.isHidden = true
        
        activityIndicator.startAnimating()
    }
    
    func clearData() {
        NetworkManager.openUrl = nil
        NetworkManager.token = nil
        NetworkManager.userID = nil
        DatabaseManager.topics = [Topic]()
    }
}


