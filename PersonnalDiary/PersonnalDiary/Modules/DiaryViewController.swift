//
//  DiaryViewController.swift
//  PersonnalDiary
//
//  Created by Kateryna Zakharchuk on 10/12/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit
import kzakharc2018

struct Database {
    static var articleManager = ArticleManager()
}

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articleRowEdit: Int?
    
    let cellIdentifier = "DiaryTableViewCell"
    var dataSource = [DiaryTableViewCellObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarSettings()
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillDataSource()
    }
    
    func fillDataSource() {
        dataSource = [DiaryTableViewCellObject]()
        let allArticles = Database.articleManager.getArticles(withLang: Locale.preferredLanguages[0].components(separatedBy: "-")[0])
        
        allArticles.forEach { (article) in
            var image: UIImage?
            var date: String?
            
            if let data = article.image as Data? {
                image = UIImage(data: data)
            } else {
                image = UIImage(named: "imageError")
            }
            
            if let create = article.created_at as Date?, let update = article.updated_at as Date? {
                date = "created at: ".localized() + handleDate(create) + "\n" + "updated at: ".localized() + handleDate(update)
            } else {
                date = ""
            }
            
            dataSource.append(DiaryTableViewCellObject(article.title, image, article.content, date))
        }
        tableView.reloadData()
    }
    
    func setupNavBarSettings() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        self.navigationItem.title = "Diary".localized()
    }
    
    @objc func touchRightBarButtonItem() {
        performSegue(withIdentifier: "NewArticleViewController", sender: self)
    }
    
    private func handleDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy HH:mm"
        return (dateFormatter.string(from: date))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NewArticleViewController") {
            if let viewController = segue.destination as? NewArticleViewController {
                let allArticles = Database.articleManager.getAllArticles()
                if let articleRowEdit = articleRowEdit {
                    viewController.articleEdit = allArticles[articleRowEdit]
                    self.articleRowEdit = nil
                }
            }
        }
    }
}

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellObject = dataSource[indexPath.row]
        let cell: DiaryTableViewCell? = DiaryTableViewCell.build(tableView, indexPath, cellObject)
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        articleRowEdit = indexPath.row
        performSegue(withIdentifier: "NewArticleViewController", sender: self)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete".localized()) { [weak self] (action, indexPath) in
            let allArticles = Database.articleManager.getAllArticles()
            Database.articleManager.removeArticle(article: allArticles[indexPath.row])
            Database.articleManager.save()
            self?.fillDataSource()
            tableView.reloadData()
        }
        return [deleteAction]
    }
}
