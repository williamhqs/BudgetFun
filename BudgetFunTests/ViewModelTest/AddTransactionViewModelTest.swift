//
//  AddTransactionViewModelTest.swift
//  BudgetFunTests
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import XCTest
import CoreData.NSManagedObjectContext
@testable import BudgetFun

class AddTransactionViewModelTest: XCTestCase {

    let viewModel = AddTransactionViewModel()
    let coreDataManager = CoreDataManager()
    var context: NSManagedObjectContext?
    
    override func setUpWithError() throws {
        viewModel.currency = .USD
        context = coreDataManager.newBackgroundContext()
        let category = coreDataManager.newWithoutSaving(Category.self, in: context!)
        category?.color = UIColor.red
        category?.createdAt = Date()
        category?.name = "Bill"
        
        viewModel.inputAmount = 2.00
        viewModel.selectedCategory = category
    }

    override func tearDownWithError() throws {
        coreDataManager.deleteAll(Category.self, in: context!)
    }

    func testConfirmButtonEnable() throws {
        XCTAssertTrue(viewModel.isValid)
    }
    
    func testConfirmButtonDisableWhenNoCategory() throws {
        viewModel.selectedCategory = nil
        XCTAssertFalse(viewModel.isValid)
    }
    
    func testConfirmButtonDisableWhenNoCurrency() throws {
        viewModel.inputAmount = 0.00
        XCTAssertFalse(viewModel.isValid)
    }

}
