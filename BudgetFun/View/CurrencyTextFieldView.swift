//
//  CurrencyTextFieldView.swift
//  BudgetFun
//
//  Created by William Hu on 3/6/20.
//  Copyright © 2020 William Hu. All rights reserved.
//
import UIKit
import SwiftUI

struct CurrencyTextFieldView: UIViewRepresentable {
    
    @Binding var currencyString: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $currencyString)
    }
    
    func makeUIView(context: Context) -> CurrencyTextField {
        let currencyField = CurrencyTextField()
        currencyField.text = "I'm the coolest CurrencyTextField"
        currencyField.delegate = context.coordinator
        return currencyField
    }
    
    func updateUIView(_ uiView: CurrencyTextField, context: Context) {
//        uiView.text = currencyString
    }
}

class Coordinator: NSObject, UITextFieldDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        text = textField.text ?? ""
        return true
    }
}
