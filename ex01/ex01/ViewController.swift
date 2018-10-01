//
//  ViewController.swift
//  ex01
//
//  Created by Kateryna Zakharchuk on 9/30/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helloWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchClickMeButton(_ sender: UIButton) {
        helloWordLabel.text = "Hello World !"
        print("Hello World !")
    }
}

