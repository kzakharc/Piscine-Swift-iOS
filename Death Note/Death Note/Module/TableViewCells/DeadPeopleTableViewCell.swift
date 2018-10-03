//
//  DeadPeopleTableViewCell.swift
//  Death Note
//
//  Created by pc166 on 10/3/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import UIKit

class DeadPeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var deathDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - CellRenewable
extension DeadPeopleTableViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? DeadPeopleTableCellObject {
            self.name.text = cellObject.name
            self.time.text = cellObject.time
            self.deathDescription.text = cellObject.description
        }
        self.selectionStyle = .none
    }
}
