//
//  CategoryExtension.swift
//  SuperBill
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

extension Transaction {
    
    class func create(coreDataManager: CoreDataManager = CoreDataManager(), category: Category, amount: Decimal, currency: Currency) {
        let context = coreDataManager.newBackgroundContext()
        let transaction = coreDataManager.newWithoutSaving(Transaction.self, in: context)
        
        do {
            let category = try context.existingObject(with: category.objectID) as? Category
            transaction?.category = category
            transaction?.amount = amount as NSDecimalNumber
            transaction?.currenceType = currency.rawValue
            let date = Date()
            transaction?.createdAt = date
            transaction?.groupTitle = date.individualDayString
            coreDataManager.saveContext(context)
        } catch {
            print(error.localizedDescription)
        }
 
    }
    
}
