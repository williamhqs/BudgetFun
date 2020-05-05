//
//  Exchange.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

struct Exchange: Codable {
    var source: String
    var timestamp: Int
    var quotes: [String: Double]
    var privacy: String
    var terms: String
}

extension Exchange {
    
    func quote(targetCurrency: Currency) -> Double? {
        let key = source + targetCurrency.rawValue
        return quotes[key]
    }
}
