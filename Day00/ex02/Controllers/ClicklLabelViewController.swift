//
//  ClicklLabelViewController.swift
//  ex02
//
//  Created by Kateryna Zakharchuk on 02.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class ClicklLabelViewController: UIViewController {

    @IBOutlet weak var helloWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchClickMeButton(_ sender: UIButton) {
        helloWordLabel.text = "Hello World !"
        print("Hello World !")
    }
}
