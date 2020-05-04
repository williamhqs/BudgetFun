//
//  UICollectionViewCellTest.swift
//  BudgetFunTests
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import XCTest
@testable import BudgetFun

class UICollectionViewCellTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIdentifier() throws {
        XCTAssertTrue(CategoryViewCell.identifier == "CategoryViewCell")
    }

}
