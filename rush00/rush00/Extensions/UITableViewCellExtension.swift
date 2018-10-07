//
//  UITableViewCellExtension.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static func build<T: UITableViewCell>(_ tableView: UITableView, _ indexPath: IndexPath, _ object: CellObjectConfigurable) -> T? where T: CellRenewable {
        
        let identifier = String(describing: object.cellClass)
        tableView.register(object.cellNib, forCellReuseIdentifier: identifier)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }
        cell.shouldUpdateCell(withObject: object)
        return cell
    }
}
