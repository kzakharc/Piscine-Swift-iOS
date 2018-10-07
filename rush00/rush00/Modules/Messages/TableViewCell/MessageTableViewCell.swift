//
//  MessageTableViewCell.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
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
extension MessageTableViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? MessageTableCellObject {
            self.message.text = cellObject.message
            self.author.text = "Written by " + cellObject.author
            self.date.text = cellObject.date
            if cellObject.isItMessage {
                background.backgroundColor = UIColor(red:0.88, green:0.71, blue:0.94, alpha:1.0)
            } else {
                background.backgroundColor = UIColor(red:0.97, green:0.94, blue:0.99, alpha:1.0)
            }
        }
        self.selectionStyle = .none
    }
}
