//
//  MainViewController.swift
//  APM
//
//  Created by pc166 on 10/4/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellIdentifier = "MainCollectionViewCell"
    private let urls = [
        "https://www.nasa.gov/sites/default/files/thumbnails/image/opo0423a_hubble_ngc2403.jpg",
        "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/45025340661_7b9f8f9402_k.jpg",
        "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/images/649694main_pia15417-43_full.jpg",
        "https://www.nasa.gov/sites/default/files/bwhi1apicaaamlo.jpg_large.jpg",
        "https://www.nasa.gov/sites/default/files/bwhi1apicaaamlo.jpg_large2.jpg"
    ]
    private var dataSource = [MainCollectionViewCellObject]()
    private var loadedImageCounter = 0
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        setupInitialDataSource()
        setupDataSource()
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.layoutCells()
    }
    
    func setupInitialDataSource() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        for _ in urls {
            dataSource.append(MainCollectionViewCellObject(nil))
        }
    }
    
    func setupDataSource() {
        dataSource = [MainCollectionViewCellObject]()
        
        for url in urls {
            dataSource.append(MainCollectionViewCellObject(URL(string: url)))
        }
    }
    
    func presentAlert(with url: String) {
        let alert = UIAlertController(title: "Erorr", message: "Cannot access to \(url)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dectinationView: ScrollViewController = segue.destination as! ScrollViewController
        dectinationView.image = self.image
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellObject = dataSource[indexPath.row]
        let cell: MainCollectionViewCell? = MainCollectionViewCell.build(collectionView, indexPath, cellObject)
        if let aCell = cell {
            aCell.getImage = { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.loadedImageCounter += 1
                if strongSelf.loadedImageCounter == strongSelf.dataSource.count {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            aCell.cantLoad = { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.presentAlert(with: strongSelf.urls[indexPath.row])
                strongSelf.loadedImageCounter += 1
                if strongSelf.loadedImageCounter == strongSelf.dataSource.count {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            aCell.touchImage = { [weak self] image in
                guard let strongSelf = self else { return }
                strongSelf.image = image
                
                if strongSelf.image != nil {
                    strongSelf.performSegue(withIdentifier: "ScrollViewController", sender: self)
                }
            }
            return aCell
        }
        return UICollectionViewCell()
    }
}

