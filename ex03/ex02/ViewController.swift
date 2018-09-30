//
//  ViewController.swift
//  ex02
//
//  Created by Kateryna Zakharchuk on 9/30/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

fileprivate enum CurrentValue {
    case first
    case second
}

fileprivate enum Operators {
    case plus
    case minus
    case star
    case slash
    case equal
}

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private var lastSymbol: Operators?
    private var firstValue: Double?
    private var secondValue: Double?
    
    private var result: Double = 0
    var needToRefresh = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "0"
    }
    
    func obtainNumber(_ number: String) -> String {
        if lastSymbol == .equal {
            lastSymbol = nil
            return number
        }
        return obtainPreviousResult() + number
    }
    
    @IBAction func touchOneButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("1")
        } else {
            resultLabel.text = "1"
            secondValue = 1
            needToRefresh = false
        }
        print("1️⃣ button pressed")
    }
    
    @IBAction func touchTwoButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("2")
        } else {
            resultLabel.text = "2"
            secondValue = 2
            needToRefresh = false
        }
        print("2️⃣ button pressed")
    }
    
    @IBAction func touchThreeButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("3")
        } else {
            resultLabel.text = "3"
            secondValue = 3
            needToRefresh = false
        }
        print("3️⃣ button pressed")
    }
    
    @IBAction func touchFourButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("4")
        } else {
            resultLabel.text = "4"
            secondValue = 4
            needToRefresh = false
        }
        print("4️⃣ button pressed")
    }
    
    @IBAction func touchFiveButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("5")
        } else {
            resultLabel.text = "5"
            secondValue = 5
            needToRefresh = false
        }
        print("5️⃣ button pressed")
    }
    
    @IBAction func touchSixButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("6")
        } else {
            resultLabel.text = "6"
            secondValue = 6
            needToRefresh = false
        }
        print("6️⃣ button pressed")
    }
    
    @IBAction func touchSevenButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("7")
        } else {
            resultLabel.text = "7"
            secondValue = 7
            needToRefresh = false
        }
        print("7️⃣ button pressed")
    }
    
    @IBAction func touchEightButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("8")
        } else {
            resultLabel.text = "8"
            secondValue = 8
            needToRefresh = false
        }
        print("8️⃣ button pressed")
    }
    
    @IBAction func touchNineButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("9")
        } else {
            resultLabel.text = "9"
            secondValue = 9
            needToRefresh = false
        }
        print("9️⃣ button pressed")
    }
    
    @IBAction func touchZeroButton(_ sender: UIButton) {
        if !needToRefresh {
            resultLabel.text = obtainNumber("0")
        } else {
            resultLabel.text = "0"
            secondValue = 0
            needToRefresh = false
        }
        print("0️⃣ button pressed")
    }
    
    @IBAction func toucnACButton(_ sender: UIButton) {
        resetProperties()
        resultLabel.text = "0"
        needToRefresh = false
        
        print("AC button pressed")
    }
    
    @IBAction func touchNEGButton(_ sender: UIButton) {
        if resultLabel.text != "0" {
            resultLabel.text = "-" + obtainPreviousResult()
        }
        
        print("NEG button pressed")
    }
    
    @IBAction func touchPlusButton(_ sender: UIButton) {
        if firstValue != nil && secondValue == nil {
            calculate(with: lastSymbol)
        }
        setupValues()
        lastSymbol = .plus
        
        if firstValue != nil && secondValue != nil {
            calculate(with: .plus)
            //firstValue = Double(resultLabel.text!)
            //secondValue = nil
        }
        needToRefresh = true
        
        print("➕ button pressed")
    }
    
    @IBAction func touchStarButton(_ sender: UIButton) {
        if firstValue != nil && secondValue == nil {
            calculate(with: lastSymbol)
        }
        setupValues()
        lastSymbol = .star
        
        if firstValue != nil && secondValue != nil {
            calculate(with: .star)
            //firstValue = Double(resultLabel.text!)
            //secondValue = nil
        }
        needToRefresh = true
        
        print("✖️ button pressed")
    }
    
    @IBAction func touchMinusButton(_ sender: UIButton) {
        if firstValue != nil && secondValue == nil {
            calculate(with: lastSymbol)
        }
        setupValues()
        lastSymbol = .minus
        
        if firstValue != nil && secondValue != nil {
            calculate(with: .minus)
            //firstValue = Double(resultLabel.text!)
            //secondValue = nil
        }
        needToRefresh = true
        
        print("➖ button pressed")
    }
    
    @IBAction func touchSlashButton(_ sender: UIButton) {
        if firstValue != nil && secondValue == nil {
            calculate(with: lastSymbol)
        }
        setupValues()
        lastSymbol = .slash
        
        if firstValue != nil && secondValue != nil {
            calculate(with: .slash)
            firstValue = Double(resultLabel.text!)
            //secondValue = nil
        }
        needToRefresh = true
        
        print("➗ button pressed")
    }
    
    @IBAction func touchEqualButton(_ sender: UIButton) {
        if firstValue == nil || lastSymbol == nil {
            return
        }
        
        calculate(with: lastSymbol!)
        
        resetProperties()
        lastSymbol = .equal
        
        print("Equal button pressed")
    }
    
    func setupValues() {
            firstValue = Double(obtainPreviousResult())
    }
    
    fileprivate func calculate(with symbol: Operators?) {
        
        if lastSymbol == .slash && secondValue == 0 {
            resultLabel.text = "Error"
            resetProperties()
            lastSymbol = nil
            return
        }
        
        switch symbol {
        case .plus?:
            let value = firstValue! + (secondValue ?? firstValue!)
            resultLabel.text = process(value)
            firstValue = value
        case .minus?:
            let value = firstValue! - (secondValue ?? firstValue!)
            resultLabel.text = process(value)
            firstValue = value
        case .star?:
            let value = firstValue! * (secondValue ?? firstValue!)
            resultLabel.text = process(value)
            firstValue = value
        case .slash?:
            let value = firstValue! / (secondValue ?? firstValue!)
            resultLabel.text = process(value)
            firstValue = value
        default:
            break
        }
    
        //secondValue = nil
        needToRefresh = true
    }
    
    func obtainPreviousResult() -> String {
        if let previousResult = (resultLabel.text == "0" || resultLabel.text == "Error") ? "" : resultLabel.text {
            return previousResult
        }
        return "0"
    }
    
    func process(_ value: Double) -> String {
        let newValue = Int(value * 10) % 10
        if newValue == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
    func resetProperties() {
        lastSymbol = nil
        firstValue = nil
        secondValue = nil
    }
}

