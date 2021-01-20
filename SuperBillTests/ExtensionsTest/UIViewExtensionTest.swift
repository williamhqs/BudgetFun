//
//  UICollectionViewCellTest.swift
//  SuperBillTests
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import XCTest
@testable import SuperBill

class UIViewExtensionTest: XCTestCase {

    func testIdentifier() throws {
        XCTAssertTrue(CategoryViewCell.identifier == "CategoryViewCell")
        XCTAssertTrue(TransactionViewCell.identifier == "TransactionViewCell")
    }

}
