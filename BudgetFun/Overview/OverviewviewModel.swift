//
//  OverViewviewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

final class OverviewviewModel {
    var transactions: [Transaction] = {
        print(CoreDataManager().get(type: Transaction.self))
        return CoreDataManager().get(type: Transaction.self)
    }()
}
