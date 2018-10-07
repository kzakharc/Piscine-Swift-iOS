//
//  TopicTableViewCell.swift
//  rush00
//
//  Created by Kateryna Zakharchuk on 07.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var background: UIView!
    
    var touchTopic:(() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background.layer.borderWidth = 1
        background.layer.borderColor = background.backgroundColor?.cgColor
        background.layer.cornerRadius = 10
    }
    
    @IBAction func touchCell(_ sender: UIButton) {
        touchTopic?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - CellRenewable
extension TopicTableViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? TopicTableViewCellObject {
            self.topicTitle.text = cellObject.topicTitle
            self.date.text = cellObject.date
            self.login.text = "Written by " + cellObject.login
        }
        self.selectionStyle = .none
    }
}
