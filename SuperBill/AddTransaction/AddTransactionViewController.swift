//
//  AddTransactionViewController.swift
//  SuperBill
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit

final class AddTransactionViewController: UIViewController {

    @IBOutlet weak var currencyAmountTextField: CurrencyTextField!
    @IBOutlet weak var currencySign: UILabel!
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    @IBOutlet weak var categoryColor: UIView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    let viewModel = AddTransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.cancelRequest()
    }
    
    private func setupViews() {
        
        currencyAmountTextField.addTarget(self, action: #selector(currencyFieldChanged), for: .editingChanged)
        currencyAmountTextField.locale = Locale(identifier: viewModel.currency.locale)
        
        guard currencySegmentControl.numberOfSegments == viewModel.currencySegmentTitles.count else { return }
        for index in 0..<currencySegmentControl.numberOfSegments {
            currencySegmentControl.setTitle(viewModel.currencySegmentTitles[index], forSegmentAt: index)
        }
        currencySign.text = viewModel.currency.sign
        categoryColor.layer.cornerRadius = 5.0
        confirmButton.isEnabled = false
        viewModel.enableConfirm = { [weak self] isEnable in
            guard let self = self else { return }
            self.confirmButton.isEnabled = isEnable
        }
    }

}

// MARK: - Actions & gestures
extension AddTransactionViewController {
    
    @IBAction func selectCategoryPressed(_ sender: UIButton) {
        
        let categoryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: CategoryViewController.identifier) as! CategoryViewController
        #warning("No need [weak self] here, the closure doesn't owned(comment should be removed)")
        categoryViewController.didSelectCategory = { category in
            self.categoryName.text = category.name?.localized
            if let color = category.color as? UIColor {
                self.categoryColor.backgroundColor = color
            }
            self.viewModel.selectedCategory = category
        }
        self.navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func currecyChanged(_ sender: UISegmentedControl) {
        viewModel.selectedCurrecyIndex = sender.selectedSegmentIndex
        currencySign.text = viewModel.currency.sign
        currencyAmountTextField.text = viewModel.calculateCurrency(currencyAmountTextField.decimal)
    }
    
    @objc func currencyFieldChanged() {
        viewModel.inputAmount = currencyAmountTextField.decimal
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        viewModel.add()
        dismiss(animated: true, completion: nil)
    }
}
