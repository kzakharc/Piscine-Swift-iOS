//
//  MessagesViewController.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [MessageTableCellObject]()
    
     let cellIdentifier = "MessageTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarSettings()
        fillDataSource()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "simoncpage"))
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fillDataSource() {
        for message in DatabaseManager.messages {
            dataSource.append(MessageTableCellObject(message.title, message.author, message.date, true))
            if message.replBool {
                message.replies.forEach({ (replie) in
                    dataSource.append(MessageTableCellObject(replie.replTitle, replie.replAuthor, replie.replDate, false))
                })
            }
        }
    }
    
    func setupNavBarSettings() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.navigationItem.title = "Messages"
    }
    
    @objc func touchRightBarButtonItem() {
//        UIView.animate(withDuration: 5) { [weak self] in
//            guard let strongSelf = self else { return }
//
//            strongSelf.tableViewTopConstraint.constant = strongSelf.addView.frame.height
//        }
    }
}

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellObject = dataSource[indexPath.row]
        let cell: MessageTableViewCell? = MessageTableViewCell.build(tableView, indexPath, cellObject)
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
}
