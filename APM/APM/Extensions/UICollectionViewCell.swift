//
//  UICollectionViewCell.swift
//  InfinityVPN
//
//  Created by pc166 on 7/5/18.
//  Copyright © 2018 jbw. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static func build<T: UICollectionViewCell>(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ object: CellObjectConfigurable) -> T? where T: CellRenewable {
        
        let identifier = String(describing: object.cellClass)
        collectionView.register(object.cellNib, forCellWithReuseIdentifier: identifier)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }
        cell.shouldUpdateCell(withObject: object)
        return cell
    }
}
