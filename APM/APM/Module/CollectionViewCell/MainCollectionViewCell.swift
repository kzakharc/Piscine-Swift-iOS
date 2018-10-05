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
    
    var getImage:(() -> ())?
    var cantLoad:(() -> ())?
    var touchImage:((_ image: UIImage) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    @IBAction func touchImage(_ sender: UIButton) {
        if let image = self.imageView.image {
            touchImage?(image)
        }
    }
    
    private func downloadImage(from url: URL,  completion: @escaping (_ image: UIImage?) -> ()) {
        print("Start downloading ...")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            let urlContents = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                print("Finish donwloading ...")
                guard let imageData = urlContents else {
                    completion(nil)
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    print("Can't load image!")
                    return
                }
                completion(UIImage(data: imageData))
            }
        }
    }


}

// MARK: - CellRenewable
extension MainCollectionViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? MainCollectionViewCellObject {
            if let url = cellObject.url {
                downloadImage(from: url) { [weak self] (image) in
                    if let image = image {
                        self?.activityIndicator.isHidden = true
                        self?.activityIndicator.stopAnimating()
                        self?.imageView.image = image
                        self?.getImage?()
                    } else {
                        self?.cantLoad?()
                    }
                }
            } else {
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            }
        }
    }
}
