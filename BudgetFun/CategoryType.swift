//
//  Category.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

enum CategoryType: Int, CaseIterable {
    case `default`, customize
    
    var title: String {
        switch self {
        case .default:
            return "default"
        case .customize:
            return "customize"
        }
    }
}

