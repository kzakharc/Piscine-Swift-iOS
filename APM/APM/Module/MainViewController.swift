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
        "https://www.nasa.gov/sites/default/files/bwhi1apicaaamlo.jpg_large.jpg"
    ]
    private var dataSource = [MainCollectionViewCellObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        setupInitialDataSource()
       // setupDataSource()
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.layoutCells()
    }
    
    func setupInitialDataSource() {
        for _ in 0...3 {
            dataSource.append(MainCollectionViewCellObject(UIImage()))
        }
    }
    
    func setupDataSource() {
        dataSource = [MainCollectionViewCellObject]()
        
        //
        
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellObject = dataSource[indexPath.row]
        let cell: MainCollectionViewCell? = MainCollectionViewCell.build(collectionView, indexPath, cellObject)
        if let aCell = cell {
            return aCell
        }
        return UICollectionViewCell()
    }
}

