//
//  OverViewviewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

final class OverviewViewModel {
    
    var transactions: [Transaction] = []
    
    func loadTransactions() {
        transactions = CoreDataManager().get(type: Transaction.self)
    }
}
