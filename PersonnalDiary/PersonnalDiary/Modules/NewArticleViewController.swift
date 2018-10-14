//
//  NewArticleViewController.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/13/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit
import kzakharc2018

class NewArticleViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var choosenImage: UIImageView!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var choosePictureButton: UIButton!
    
    var imagePicker: UIImagePickerController! = UIImagePickerController()
    var articleEdit: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarSettings()
        localizeItems()
        
        imagePicker.delegate = self
        
        if let article = articleEdit {
            titleTextField.text = article.title
            descriptionTextField.text = article.content
            if let data = article.image as Data? {
                choosenImage.image = UIImage(data: data)
            } else {
                choosenImage.image = UIImage(named: "imageError");
            }
        }
    }
    
    @IBAction func touchTakePicture(_ sender: UIButton) {
        if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let alertController = UIAlertController.init(title: nil, message: "Device has no camera.".localized(), preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchChoosePicture(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func setupNavBarSettings() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(touchRightBarButtonItem))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(touchLeftBarButtonItem))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        self.navigationItem.title = "Article".localized()
    }
    
    @objc func touchRightBarButtonItem() {
        if let title = titleTextField.text, let description = descriptionTextField.text {
            if !title.isEmpty && !description.isEmpty {
                let article = Database.articleManager.newArticle()
                article.title = title
                article.content = description
                if let aEdit = articleEdit {
                    article.created_at = aEdit.created_at
                    Database.articleManager.removeArticle(article: aEdit)
                } else {
                    article.created_at = NSDate()
                }
                article.updated_at = NSDate()
                article.language = Locale.preferredLanguages[0].components(separatedBy: "-")[0]
                
                let image = choosenImage.image != nil ? choosenImage.image! : UIImage(named: "imageError")
                article.image = UIImagePNGRepresentation(image!) as NSData?
                Database.articleManager.save()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func touchLeftBarButtonItem() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewArticleViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        choosenImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
}

extension NewArticleViewController: Localizable {
    
    func localizeItems() {
        takePictureButton.localize(forKey: "Take picture")
        choosePictureButton.localize(forKey: "Choose picture")
    }
}
