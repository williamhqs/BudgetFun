//
//  CoreDataManagerTest.swift
//  BudgetFunTests
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import XCTest
import CoreData.NSManagedObjectContext
@testable import BudgetFun

class CoreDataManagerTest: XCTestCase {

    let coreDataManager = CoreDataManager()
    var context: NSManagedObjectContext?
    var category: BudgetFun.Category?
    
    override func setUpWithError() throws {
        context = coreDataManager.newBackgroundContext()
        category = coreDataManager.newWithoutSaving(Category.self, in: context!)
        category!.color = UIColor.red
        category!.createdAt = Date()
        category!.name = "Bill"
        category!.type = CategoryType.default.rawValue
    }

    override func tearDownWithError() throws {
        coreDataManager.deleteAll(Category.self, in: context!)
    }

    func testInsertCategory() throws {
        let categoriesBeforeSave = coreDataManager.get(type: Category.self)
        XCTAssertTrue(categoriesBeforeSave.count == 0)
        coreDataManager.saveContext(context!)
        let categories = coreDataManager.get(type: Category.self)
        XCTAssertTrue(categories.count == 1)
    }
    
    func testInsertTransAction() throws {
        let transaction = coreDataManager.newWithoutSaving(Transaction.self, in: context!)
        transaction?.category = category
        coreDataManager.saveContext(context!)
        let transactions = coreDataManager.get(type: Transaction.self)
        XCTAssertTrue(transactions.count == 1)
        let categories = coreDataManager.get(type: Category.self)
        XCTAssertTrue(categories.count == 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
