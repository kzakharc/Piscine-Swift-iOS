//
//  ListViewController.swift
//  Kanto
//
//  Created by Kateryna Zakharchuk on 08.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit
import MapKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "ListTableViewCell"
    var dataSource = [ListTableViewCellObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillDataSource()

        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func fillDataSource() {
        dataSource.append(ListTableViewCellObject("Ecole 42\n96 Boulevard Bessières, 75017 Paris, France", CLLocationCoordinate2D(latitude: 48.896822, longitude: 2.318511), "Ecole 42", "42 BORN TO CODE ?"))
        dataSource.append(ListTableViewCellObject("UNIT\nUkraine, Kyiv, Dorohozhytska St, 3 (campus entrance near Dorohozhytska Str, 1)", CLLocationCoordinate2D(latitude: 50.468979, longitude: 30.462148), "UNIT", "42 BORN TO CODE ?"))
        dataSource.append(ListTableViewCellObject("Cimema\nUkraine, Kyiv, st. Gnat Hotkevich, 1B", CLLocationCoordinate2D(latitude: 50.455597, longitude: 30.634751), "Cimema", "Multiplex complex"))
        dataSource.append(ListTableViewCellObject("Сircus\nUkraine, Kyiv, square Victory, 2", CLLocationCoordinate2D(latitude: 50.449146, longitude: 30.492719), "Сircus", "If you wanna some action"))
        dataSource.append(ListTableViewCellObject("Home\nUkraine, Kyiv, st. Georgy Toropovskogo, 41", CLLocationCoordinate2D(latitude: 50.448766, longitude: 30.612060), "Home", "Sweet home"))
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellObject = dataSource[indexPath.row]
        let cell: ListTableViewCell? = ListTableViewCell.build(tableView, indexPath, cellObject)
        if let aCell = cell {
            aCell.touchMessage = { [weak self] in
                Locale.coortinates = cellObject.coortinates
                Locale.title = cellObject.title
                Locale.subtitle = cellObject.subtitle
                self?.tabBarController?.selectedIndex = 0
            }
            return aCell
        }
        return UITableViewCell()
    }
}

