//
//  OverViewviewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import CoreData

struct OverviewViewModel {
    
    var fetchedResultsController: NSFetchedResultsController<Transaction> {
        let fetchedRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        fetchedRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Transaction.groupTitle, ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: CoreDataManager().persistentContainer.viewContext, sectionNameKeyPath: #keyPath(Transaction.groupTitle), cacheName: nil)
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return controller
    }
}
