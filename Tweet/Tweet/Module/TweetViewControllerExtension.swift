//
//  TweetViewControllerExtension.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 05.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

extension TweetViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1//dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellObject = dataSource[indexPath.section] as! DeadPeopleTableCellObject
//        let cell: DeadPeopleTableViewCell? = DeadPeopleTableViewCell.build(tableView, indexPath, cellObject)
//        if let aCell = cell {
//            return aCell
//        }
        return UITableViewCell()
    }
}
