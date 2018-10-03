//
//  DeathNoteViewController.swift
//  Death Note
//
//  Created by pc166 on 10/3/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import UIKit

enum SectionIdentifiers {
    case firstDude
    case secondDude
    case thirdDude
}

class DeathNoteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections: [SectionIdentifiers] = [.firstDude, .secondDude, .thirdDude]
    var dataSource: [CellObjectConfigurable] = [DeadPeopleTableCellObject]()
    
    let cellIdentifier = "DeadPeopleTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        setupCellData()
    }
    
    func setupCellData() {
        let firstCell = DeadPeopleTableCellObject("Bob Martin", "5 may 2036 15:03:57", "Swallow gum.")
        let secondCell = DeadPeopleTableCellObject("Rob Dilan", "14 september 2019 11:04:02", "Slipped on a banana.")
        let thirdCell = DeadPeopleTableCellObject("Kira Nightly", "10 may 2056 00:03:24", "Will die of laughter.")
        
        dataSource.append(firstCell)
        dataSource.append(secondCell)
        dataSource.append(thirdCell)
    }
    
    @IBAction func addPersonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "add_person", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add_person" {
            if let destinationVC = segue.destination as? NewGhoulViewController {
                destinationVC.completionHandler = { [weak self] person in
                    guard let `self` = self else { return }
                    self.dataSource.append(person)
                    let indexSet = IndexSet(integer: self.dataSource.count - 1)
                    self.tableView.insertSections(indexSet, with: .automatic)
                }
            }
        }
    }
}

