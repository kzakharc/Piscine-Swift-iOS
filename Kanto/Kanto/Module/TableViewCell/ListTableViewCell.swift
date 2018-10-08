//
//  ListTableViewCell.swift
//  Kanto
//
//  Created by Kateryna Zakharchuk on 08.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var background: UIView!
    
    var touchMessage:(() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background.layer.borderWidth = 1
        background.layer.borderColor = background.backgroundColor?.cgColor
        background.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func touchCell(_ sender: UIButton) {
        touchMessage?()
    }
}

// MARK: - CellRenewable
extension ListTableViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? ListTableViewCellObject {
            self.name.text = cellObject.name
        }
        self.selectionStyle = .none
    }
}
