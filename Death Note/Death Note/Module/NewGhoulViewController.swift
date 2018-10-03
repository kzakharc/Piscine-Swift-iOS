//
//  NewGhoulViewController.swift
//  Death Note
//
//  Created by Kateryna Zakharchuk on 03.10.2018.
//  Copyright © 2018 pc166. All rights reserved.
//

import UIKit

class NewGhoulViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var completionHandler:((DeadPeopleTableCellObject) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialSettings()
    }
    
    func setupInitialSettings() {
        setupNavBarSettings()
        
        addBorderToTextFiels()
        datePicker.minimumDate = Date()
    }
    
    func setupNavBarSettings() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(touchRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.navigationItem.title = "Add a Person"
    }
    
    @objc func touchRightBarButtonItem() {
        if (nameTextField.text!.isEmpty) {
            print("Empty name!");
            return
        }
        print("Person name: \(nameTextField.text!)")
        print("Time: \(datePicker.date)")
        print("Description: \(descriptionTextField.text!)")
        let person = DeadPeopleTableCellObject(nameTextField.text!, String(describing: datePicker.date), descriptionTextField.text)
        completionHandler?(person)
        navigationController?.popViewController(animated: true)
    }
    
    func addBorderToTextFiels() {
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        descriptionTextField.layer.borderWidth = 1
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

