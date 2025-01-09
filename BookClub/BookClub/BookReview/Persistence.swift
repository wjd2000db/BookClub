// FILE : Persistence.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file sets up the PersistenceController for managing the Core Data stack.

import Foundation
import CoreData
import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CDModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("ERROR:PersistenceController \(error), \(error.userInfo)")
            }
        }
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
