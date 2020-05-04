//
//  AddTransactionViewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

final class AddTransactionViewModel {

    var selectedCategory: Category?
    var inputAmount: Decimal?
    var currency: Currency = .USD
    var currecyRate: Double?
    
    var selectedCurrecyIndex: Int = 0 {
        didSet {
            currency = Currency.allCases[selectedCurrecyIndex]
        }
    }
    
    var currencySegmentTitles: [String] {
        return Currency.allCases.map { $0.rawValue }
    }
    
    init() {
        getCurrencyRate()
    }
    
    func calculateCurrency(_ amount: Decimal) -> String {
        
        guard let rate = currecyRate, rate != 0 else {
            return ""
        }
        if currency == .USD {
            return Decimal(Double(truncating: amount as NSNumber) / rate).currency
        } else {
            return Decimal(Double(truncating: amount as NSNumber) * rate).currency
        }
    }
    
    private func getCurrencyRate () {
        NetworkManager().requestCurrencyRate { (exchange) in
            self.currecyRate = exchange?.quote(targetCurrency: .NZD)
        }
    }
    
    func add() {
        
        guard let category = selectedCategory else {
            #warning("Validate alert, category can't be nil")
            return
        }
        
        guard let amount = inputAmount else {
            #warning("Validate alert, inputAmount can't be nil")
            return
        }
        
        Transaction.create(category: category, amount: amount, currency: currency)

    }
    
}
