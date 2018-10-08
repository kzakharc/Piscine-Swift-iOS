//
//  ListTableViewCellObject.swift
//  Kanto
//
//  Created by Kateryna Zakharchuk on 08.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ListTableViewCellObject {
    
    var name = String()
    var coortinates = CLLocationCoordinate2D()
    var title = String()
    var subtitle = String()
    
    init(_ name: String, _ coortinates: CLLocationCoordinate2D, _ title: String, _ subtitle: String) {
        self.name = name
        self.coortinates = coortinates
        self.title = title
        self.subtitle = subtitle
    }
}

// MARK: - CellObjectConfigurable
extension ListTableViewCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return ListTableViewCell.self
    }
    
    var cellNib: UINib {
        return UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil)
    }
}
