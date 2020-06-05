//
//  CategoryViewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import CoreData
import UIKit

typealias RequestCompletion = (Exchange?, URLResponse?, Error?) -> ()

final class CategoryViewModel {
    
    var categorySectionCount = CategoryType.allCases.count
    var selectedCategory: Category?
    var coreDataManager = CoreDataManager()
    
    func preloadCategories() {
        let categories = coreDataManager.get(type: Category.self)
        guard categories.count == 0 else {
            return
        }
        var categoryArray = [Category]()
        ConstantString.Category().categories.forEach {
            let newCategory = Category(context: fetchedResultsController.managedObjectContext)
            newCategory.name = $0.localized
            newCategory.color = UIColor.cyan
            newCategory.type = CategoryType.default.rawValue
            categoryArray.append(newCategory)
        }
            

        do {
            try fetchedResultsController.managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    var fetchedResultsController: NSFetchedResultsController<Category> {
        let fetchedRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchedRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Category.createdAt, ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return controller
    }
    
}
