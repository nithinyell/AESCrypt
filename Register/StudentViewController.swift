//
//  ViewController.swift
//  Register
//
//  Created by Nithin on 28/12/19.
//  Copyright © 2019 Nithin. All rights reserved.
//

import UIKit
import CoreData

class StudentViewController: UIViewController {

    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var addNewStudent: UIBarButtonItem!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var students = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        studentTableView.tableFooterView = UIView(frame: .zero)
        reloadData()
    }

    @IBAction func addNewStudent(_ sender: Any) {
       addNewStudents()
    }
    
    func addNewStudents() {
        
        let alert = UIAlertController(title: "Add New Student", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Course"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert,self] (_) in
            if let name = alert?.textFields?[0].text, name.isEmpty == false, let course = alert?.textFields?[1].text, course.isEmpty == false, let age = alert?.textFields?[2].text, age.isEmpty == false {
                
                DataManager.default.save(name.capitalized, course.capitalized, age)
                self.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func reloadData() {
        DataManager.default.fetch(completion: { [weak self](students) in
            
            if students.count > 0 {
                self?.students = students
                noDataLabel.isHidden = true
                studentTableView.reloadData()
            }
        })
    }
}

extension StudentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StudentTableViewCell
        let student = students[indexPath.row]
        
        cell?.name.text = AESCrypt.AESStringDecryption(message: student.value(forKey: "name") as? String)
        cell?.course.text = AESCrypt.AESStringDecryption(message: student.value(forKey: "course") as? String)
        cell?.age.text = AESCrypt.AESStringDecryption(message: student.value(forKey: "age") as? String)
        
        return cell ?? UITableViewCell()
    }
}
