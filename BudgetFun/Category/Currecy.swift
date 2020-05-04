//
//  Currecy.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

enum Currency: String, CaseIterable {
    case USD = "USD"
    case NZD = "NZD"
    
    var sign: String {
        switch self {
        case .USD:
            return "US$"
        case .NZD:
            return "NZ$"
        }
    }
    
    var locale: String {
        switch self {
        case .USD:
            return "en_US"
        case .NZD:
            return "en_NZ"
        }
    }
}

