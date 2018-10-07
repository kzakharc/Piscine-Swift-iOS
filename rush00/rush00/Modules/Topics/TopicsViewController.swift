//
//  TopicsViewController.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTopConstaint: NSLayoutConstraint!
    
    let cellIdentifier = "TopicTableViewCell"
    var count = 0
    
    var dataSource = [TopicTableViewCellObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarSettings()
        fillDataSource()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "simoncpage"))
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        count = 0
        setupInitialSettings()
        
        addButton.layer.borderWidth = 0.5
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.cornerRadius = 5

        tableViewTopConstraint.constant = 0
    }
    
    func setupInitialSettings() {
        DatabaseManager.messages = [Messages]()
        background.isHidden = true
        activityIndicator.isHidden = true
        
        activityIndicator.startAnimating()
    }
    
    @IBAction func touchAddButton(_ sender: UIButton) {
        UIView.animate(withDuration: 5) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.tableViewTopConstraint.constant = 0
        }
    }
    
    
    func fillDataSource() {
        DatabaseManager.topics.forEach { [weak self] (topics) in
            self?.dataSource.append(TopicTableViewCellObject(topics.name, topics.date, topics.authorLogin, topics.id))
        }
    }
    
    func setupNavBarSettings() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.navigationItem.title = "Topics"
    }
    
    @objc func touchRightBarButtonItem() {
        UIView.animate(withDuration: 5) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.tableViewTopConstraint.constant = strongSelf.addView.frame.height
        }
    }
}

extension TopicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellObject = dataSource[indexPath.row]
        let cell: TopicTableViewCell? = TopicTableViewCell.build(tableView, indexPath, cellObject)
        if let aCell = cell {
            aCell.touchTopic = { [weak self] in
                self?.background.alpha = 0
                self?.background.isHidden = false
                self?.activityIndicator.isHidden = false
                UIView.animate(withDuration: 1, animations: { [weak self] in
                    self?.background.alpha = 0.6
                })
                
                NetworkManager.obtainMessages(cellObject.topicId, completion: {
                     DispatchQueue.main.async { [weak self] in
                        if self?.count == 0 {
                            self?.performSegue(withIdentifier: "MessagesViewController", sender: self)
                        }
                        self?.count += 1
                    }
                })
            }
            return aCell
        }
        return UITableViewCell()
    }
}
