//
//  CoreDataManager.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    func newBackgroundContext() -> NSManagedObjectContext {
        let newContext = persistentContainer.newBackgroundContext()
        newContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return newContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "BudgetFun")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
       
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait {
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
//    func create<T>(_ type: T.Type, on context: NSManagedObjectContext, generatingBlock: ((inout T) -> ())) -> T where T : NSManagedObject {
//
//    }
}

// MARK: - Query
extension CoreDataManager {
    
    /// This is for reading from main thread
    
    func get<T: NSManagedObject>(type: T.Type, with predicate: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil, in context: NSManagedObjectContext? = nil) -> [T] {
        let entityName = T.entityName
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        let context = context ?? persistentContainer.viewContext
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorting
        
        var objects = [T]()
        context.performAndWait {
            do {
                let result = try context.fetch(fetchRequest)
                objects = result
            } catch {
                print("Cannot fetch  \(entityName). Error: \(error)")
            }
        }
        
        return objects
    }
    
    func newWithoutSaving<T: NSManagedObject>(_ type: T.Type, in context: NSManagedObjectContext) -> T? {
        var entity: NSEntityDescription?
        context.performAndWait {
            entity = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        }
        
        let result = NSManagedObject(entity: entity!, insertInto: context) as? T
        
        assert(result != nil, "Failed to create managed object for type \(type)")
        
        return result
    }
    
    /// Update from background queue
    
    func insert<T: NSManagedObject>(_ type: T.Type, assignCallback: @escaping (T?) -> Void, completion: ((T?) -> Void)? = nil)  {
        let backgroundContext = newBackgroundContext()
        backgroundContext.perform {
            let entity =  NSEntityDescription.entity(forEntityName: T.entityName, in: backgroundContext)
            let object = NSManagedObject(entity: entity!, insertInto: backgroundContext) as? T
            do {
                if backgroundContext.hasChanges {
                    do {
                        try backgroundContext.save()
                        backgroundContext.reset()
                    } catch {
                        print("error \(error)")
                    }
                }
                
                
            } catch {
                print("Error on saving created object: \(error)")
            }
        }
        
    }
    
    func create<T: NSManagedObject>(_ type: T.Type, in context: NSManagedObjectContext) -> T? {
        var entity: NSEntityDescription?
        context.performAndWait {
            entity = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        }
        
        let result = NSManagedObject(entity: entity!, insertInto: context) as? T
        
        assert(result != nil, "Failed to create managed object for type \(type)")
        
        return result
    }
    
    func deleteAll<T: NSManagedObject>(_ type: T.Type, in context: NSManagedObjectContext) {
        
        context.performAndWait {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
            do {
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                try context.execute(deleteRequest)
            } catch {
                print("I lovee you")
                print(error)
            }
        }
    }
}



