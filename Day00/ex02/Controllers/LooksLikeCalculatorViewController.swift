//
//  LooksLikeCalculatorViewController.swift
//  ex02
//
//  Created by Kateryna Zakharchuk on 02.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class LooksLikeCalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "0"
    }
    
    @IBAction func touchOneButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "1"
        print("1️⃣ button pressed")
    }
    
    @IBAction func touchTwoButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "2"
        print("2️⃣ button pressed")
    }
    
    @IBAction func touchThreeButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "3"
        print("3️⃣ button pressed")
    }
    
    @IBAction func touchFourButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "4"
        print("4️⃣ button pressed")
    }
    
    @IBAction func touchFiveButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "5"
        print("5️⃣ button pressed")
    }
    
    @IBAction func touchSixButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "6"
        print("6️⃣ button pressed")
    }
    
    @IBAction func touchSevenButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "7"
        print("7️⃣ button pressed")
    }
    
    @IBAction func touchEightButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "8"
        print("8️⃣ button pressed")
    }
    
    @IBAction func touchNineButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "9"
        print("9️⃣ button pressed")
    }
    
    @IBAction func touchZeroButton(_ sender: UIButton) {
        resultLabel.text = obtainPreviousResult() + "0"
        print("0️⃣ button pressed")
    }
    
    @IBAction func toucnACButton(_ sender: UIButton) {
        print("AC button pressed")
    }
    
    @IBAction func touchNEGButton(_ sender: UIButton) {
        print("NEG button pressed")
    }
    
    @IBAction func touchPlusButton(_ sender: UIButton) {
        print("➕ button pressed")
    }
    
    @IBAction func touchStarButton(_ sender: UIButton) {
        print("✖️ button pressed")
    }
    
    @IBAction func touchMinusButton(_ sender: UIButton) {
        print("➖ button pressed")
    }
    
    @IBAction func touchSlashButton(_ sender: UIButton) {
        print("➗ button pressed")
    }
    
    @IBAction func touchEqualButton(_ sender: UIButton) {
        print("Equal button pressed")
    }
    
    func obtainPreviousResult() -> String {
        if let previousResult = (resultLabel.text == "0") ? "" : resultLabel.text {
            return previousResult
        }
        return String()
    }
}
