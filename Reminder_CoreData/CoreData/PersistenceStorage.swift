//
//  PersistenceStorage.swift
//  Reminder_CoreData
//
//  Created by Ramesh on 26/06/21.
//

import Foundation
import CoreData

class PersistanceStorage {
    
   static let sharedInstance = PersistanceStorage()
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "Reminder_CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
         
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
   lazy var context = persistentContainer.viewContext
    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
          
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
