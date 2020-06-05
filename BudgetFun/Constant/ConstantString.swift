//
//  Constant+String.swift
//  BudgetFun
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

struct ConstantString {
    enum OverView: String {
        case navigationTitle = "Overview"
    }

    enum CategoryTitle: String {
        case navigationTitle = "Category"
    }
    
    struct Category {
        let categories = ["Food".localized, "Play".localized]
    }
    
}







