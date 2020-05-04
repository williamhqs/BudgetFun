//
//  CategoryViewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation
import CoreData

class CategoryViewModel {
    
    var categorySectionCount = CategoryType.allCases.count
    var managedObjectContext: NSManagedObjectContext?
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func a () {
    
    }
}
