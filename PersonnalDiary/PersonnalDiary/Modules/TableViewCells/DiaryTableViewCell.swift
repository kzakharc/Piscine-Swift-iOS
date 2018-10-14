//
//  DiaryTableViewCell.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/12/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - CellRenewable
extension DiaryTableViewCell: CellRenewable {
    
    func shouldUpdateCell(withObject object: CellObjectConfigurable?) {
        if let cellObject = object as? DiaryTableViewCellObject {
            self.titleLabel.text = cellObject.title
            self.photo.image = cellObject.photo
            self.contentLabel.text = cellObject.content
            self.dateLabel.text = cellObject.date
        }
        self.selectionStyle = .none
    }
}
