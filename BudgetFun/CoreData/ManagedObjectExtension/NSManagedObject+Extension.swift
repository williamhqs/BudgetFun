//
//  NSManagedObject+Extension.swift
//  BudgetFun
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import CoreData.NSManagedObjectContext

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
