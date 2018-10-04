//
//  MainCollectionViewCell.swift
//  APM
//
//  Created by pc166 on 10/4/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.activityIndicator.hidesWhenStopped = true
    }

}

// MARK: - CellRenewable
extension MainCollectionViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? MainCollectionViewCellObject {
            if cellObject.image == UIImage() {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.imageView.image = cellObject.image
            }
        }
    }
}
