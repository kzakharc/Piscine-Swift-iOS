//
//  AuthViewController.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/12/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {
    
    private let context = LAContext()
    var localizedReason = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        localizeItems()
        
        auth()
    }
    
    func auth() {
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: localizedReason) { [weak self] (success, error) in
                guard let strongSelf = self else { return }
                
                if success {
                    DispatchQueue.main.async {
                        strongSelf.performSegue(withIdentifier: "DiaryViewController", sender: strongSelf)
                    }
                } else {
                    self?.auth()
                    print("❌")
                }
            }
        }
    }
}

extension AuthViewController: Localizable {
    func localizeItems() {
        localizedReason = "You have to be authenticate to use this Diary".localized()
        
        navigationItem.title = "Auth".localized()
    }
}

