//
//  CurrencyField.swift
//  SuperBill
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {
    
    private var lastValue: String?
    
    var maximum: Decimal = 999_999_999.99
    
    var decimal: Decimal {
        string.decimal / pow(10, Formatter.currency.maximumFractionDigits)
    }
    
    var locale: Locale = .current {
        didSet {
            Formatter.currency.locale = locale
            sendActions(for: .editingChanged)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        Formatter.currency.locale = locale
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    
    override func deleteBackward() {
        text = string.digits.dropLast().string
        sendActions(for: .editingChanged)
    }
    
    @objc func editingChanged() {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = decimal.currency
        lastValue = text
    }
    
}

extension CurrencyTextField {
    var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
}
