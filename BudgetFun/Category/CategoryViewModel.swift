//
//  CategoryViewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import CoreData

typealias RequestCompletion = (Exchange?, URLResponse?, Error?) -> ()

final class CategoryViewModel {
    
    var categorySectionCount = CategoryType.allCases.count
    
    var selectedCategory: Category?
    
   
}
