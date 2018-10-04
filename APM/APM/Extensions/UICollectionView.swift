//
//  UICollectionView.swift
//  InfinityVPN
//
//  Created by pc166 on 7/3/18.
//  Copyright © 2018 jbw. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func layoutCells(_ insetFromTop: CGFloat = 0.0) {
        
        let cellsWidth = UIScreen.main.bounds.width / 2 - 10
        let cellsHeight = cellsWidth
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellsWidth, height: cellsHeight)
        layout.sectionInset = UIEdgeInsets(top: insetFromTop, left: 0.0, bottom: 0.0, right: 0.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.collectionViewLayout = layout
    }
}
