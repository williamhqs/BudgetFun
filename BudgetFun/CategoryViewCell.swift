//
//  CategoryViewCell.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit

final class CategoryViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    
    func configure(by category: Category) {
        categoryName.text = category.name
        categoryColorView.backgroundColor = UIColor.red
    }
}
