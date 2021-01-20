//
//  AddTransactionViewModel.swift
//  SuperBill
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

final class AddTransactionViewModel {

    var currency: Currency = .USD
    var currecyRate: Double?
    var enableConfirm: ((Bool)->Void)?
    private let networkManager = NetworkManager()
    
    var isValid: Bool {
        return selectedCategory != nil && inputAmount != nil && inputAmount != 0.00
    }
    
    var selectedCategory: Category? {
        didSet {
            enableConfirm?(isValid)
        }
    }
    
    var inputAmount: Decimal? {
        didSet {
            enableConfirm?(isValid)
        }
    }
    
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
    
    func cancelRequest() {
        networkManager.cancel()
    }
    
    private func getCurrencyRate () {
        networkManager.requestCurrencyRate { (exchange) in
            self.currecyRate = exchange?.quote(targetCurrency: .NZD)
        }
    }
    
    func add(_ coreDataManager: CoreDataManager = CoreDataManager()) {
        
        guard let category = selectedCategory else {
            #warning("Validate alert, category can't be nil")
            return
        }
        
        guard let amount = inputAmount else {
            #warning("Validate alert, inputAmount can't be nil")
            return
        }
        
        Transaction.create(coreDataManager: coreDataManager, category: category, amount: amount, currency: currency)

    }
    
}
