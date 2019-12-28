//
//  DataManager.swift
//  Register
//
//  Created by Nithin on 28/12/19.
//  Copyright © 2019 Nithin. All rights reserved.
//

import CoreData
import UIKit

class DataManager {

    static let `default` = DataManager()
    
    func save(_ name: String, _ course: String, _ age: String) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = delegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Students", in: context) {
            let student = NSManagedObject(entity: entity, insertInto: context)
            student.setValue(AESCrypt.AESStringEncryption(message: name), forKey: "name")
            student.setValue(AESCrypt.AESStringEncryption(message: course), forKey: "course")
            student.setValue(AESCrypt.AESStringEncryption(message: age), forKey: "age")
            
            do {
                
                try context.save()
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func fetch(completion: (([NSManagedObject]) -> Void)) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = delegate.persistentContainer.viewContext
        
        let fetchedStudents = NSFetchRequest<NSManagedObject>(entityName: "Students")
        
        do {
            let students = try context.fetch(fetchedStudents)
            completion(students)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
