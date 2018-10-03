//
//  DeathNoteViewControllerExtension.swift
//  Death Note
//
//  Created by pc166 on 10/3/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import Foundation
import UIKit

extension DeathNoteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellObject = dataSource[indexPath.section] as! DeadPeopleTableCellObject
        let cell: DeadPeopleTableViewCell? = DeadPeopleTableViewCell.build(tableView, indexPath, cellObject)
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
}
