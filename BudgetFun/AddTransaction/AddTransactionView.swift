//
//  AddTransactionView.swift
//  BudgetFun
//
//  Created by William Hu on 30/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import SwiftUI

struct AddTransactionView: View {
    
    var dismissAction:(()-> Void)? = nil
    let dismissTitle: LocalizedStringKey = "Dismiss"
    let confirmTitle: LocalizedStringKey = "Confirm"
    
    @State var currencyTextFieldString = ""
    
    init(dismissAction: (()-> Void)?) {
        self.dismissAction = dismissAction
    }
    
    var body: some View {
        VStack() {
            HStack() {
                Button(action: {
                    self.dismissAction?()
                }) {
                    Text(dismissTitle)
                        .padding([.leading, .trailing])
                }
                Spacer()
                Button(action: {
                    self.dismissAction?()
                }) {
                    Text(confirmTitle)
                    .padding()
                }
            }
            
            CurrencyTextFieldView(currencyString: $currencyTextFieldString)
                .background(Color(UIColor.lightGray))
                .frame(height: 44)
                //.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 1))
            Spacer()

            
        }.padding()
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(dismissAction: nil)
    }
}
