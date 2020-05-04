//
//  AddTransactionViewController.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {

    @IBOutlet weak var currencyAmountTextField: CurrencyField!
    @IBOutlet weak var currencySign: UILabel!
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    
    let viewModel = AddTransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        currencyAmountTextField.addTarget(self, action: #selector(currencyFieldChanged), for: .editingChanged)
        currencyAmountTextField.locale = Locale(identifier: viewModel.currency.locale)
        
    }
    
    @objc func currencyFieldChanged() {
        print("decimal:", currencyAmountTextField.decimal)
    }
    
    private func setupViews() {
        guard currencySegmentControl.numberOfSegments == viewModel.currencySegmentTitles.count else { return }
        for index in 0..<currencySegmentControl.numberOfSegments {
            currencySegmentControl.setTitle(viewModel.currencySegmentTitles[index], forSegmentAt: index)
        }
        currencySign.text = viewModel.currency.sign
        currencyAmountTextField.text = "0.00"
    }

}

// MARK: - Actions & gestures
extension AddTransactionViewController {
    
    @IBAction func selectCategoryPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func currecyChanged(_ sender: UISegmentedControl) {
        viewModel.selectedCurrecyIndex = sender.selectedSegmentIndex
        currencySign.text = viewModel.currency.sign
        currencyAmountTextField.text = viewModel.calculateCurrency(currencyAmountTextField.decimal)
    }
    
}
