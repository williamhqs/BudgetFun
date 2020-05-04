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
    
    func preloadCategories(context: NSManagedObjectContext) {
        let categories = CoreDataManager().get(type: Category.self)
        guard categories.count == 0 else {
            return
        }
        var categoryArray = [Category]()
        for index in 0...3 {
            let newCategory = Category(context: context)
            newCategory.name = "Bill" + String(index)
            newCategory.color = [UIColor.blue, .red, .green, .cyan][index]
            newCategory.type = CategoryType.default.rawValue
            categoryArray.append(newCategory)
        }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
