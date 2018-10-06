//
//  TweetTableViewCell.swift
//  Tweet
//
//  Created by Kateryna Zakharchuk on 05.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tweetDescription: UILabel!
    @IBOutlet weak var back: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        back.backgroundColor = UIColor(red:0.35, green:0.68, blue:0.82, alpha:1.0)
        
        back.layer.borderWidth = 1
        back.layer.borderColor = UIColor(red:0.35, green:0.68, blue:0.82, alpha:1.0).cgColor
        back.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


// MARK: - CellRenewable
extension TweetTableViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? TweetTableViewCellObject {
            name.text = cellObject.name
            date.text = cellObject.date
            tweetDescription.text = cellObject.tweetDescription
        }
        self.selectionStyle = .none
    }
}

