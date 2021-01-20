//
//  Decimal+Extension.swift
//  SuperBill
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

extension Decimal {
    var currency: String { Formatter.currency.string(for: self) ?? "" }
}
