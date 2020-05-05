//
//  String+Extension.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit

extension CurrencyField {
    var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
}

extension UITextField {
     var string: String { text ?? "" }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

extension Formatter {
    static let currency: NumberFormatter = .init(numberStyle: .currency)
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter { $0.isWholeNumber } }
}

extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
    
    var localized:String {
        return NSLocalizedString(self, comment: "")
    }
}

extension Decimal {
    var currency: String { Formatter.currency.string(for: self) ?? "" }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
