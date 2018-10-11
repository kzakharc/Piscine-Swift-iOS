//
//  MainViewController.swift
//  Siri
//
//  Created by Kateryna Zakharchuk on 10/10/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var questonTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchAskButton(_ sender: UIButton) {
        guard let text = questonTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        if text.isEmpty { return }
        
        if let queston = questonTextField.text {
            networkManager.obtainLocale(queston, completion: { [weak self] (answer) in
                DispatchQueue.main.async {
                    self?.answerLabel.text = answer
                }
            })
        }
    }
    
    // MARK: keyboard settings
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

