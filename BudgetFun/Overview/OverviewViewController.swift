//
//  OverviewViewController.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    let viewModel = OverviewViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTrsaction))
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 50
        title = ConstantString.OverView.navigationTitle.rawValue.localized
    }
    
    @objc func addNewTrsaction() {
        let addTransactionViewController = AddTransactionViewController(nibName: AddTransactionViewController.identifier, bundle: nil)
        let navigationController = UINavigationController(rootViewController: addTransactionViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
}

extension OverviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = viewModel.fetchedResultsController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.identifier, for: indexPath) as! TransactionViewCell
        let transaction = viewModel.fetchedResultsController.object(at: indexPath)
        cell.configure(by: transaction)
        return cell
    }
    
    
}
