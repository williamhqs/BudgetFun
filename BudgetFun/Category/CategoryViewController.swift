//
//  CategoryViewController.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit
import CoreData
import SwiftUI

final class CategoryViewController: UIViewController {
    
    private let viewModel = CategoryViewModel()
    var didSelectCategory: ((Category) -> Void)?
    let detailsView = DetailsView()
    
    @IBSegueAction func showDetails(_ coder: NSCoder) -> UIViewController? {
        let detailsView = DetailsView()
        return UIHostingController(coder: coder, rootView: detailsView)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private func setupViews() {
        let flow = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 3
        let itemsInOneLine: CGFloat = 3
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.size.width - itemSpacing * CGFloat(itemsInOneLine - 1)
        flow.itemSize = CGSize(width: floor(width/itemsInOneLine), height: width/itemsInOneLine)
        flow.minimumInteritemSpacing = 1
        flow.minimumLineSpacing = 1
        collectionView.collectionViewLayout = flow
        navigationItem.title = ConstantString.Category.navigationTitle.rawValue.localized
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        viewModel.preloadCategories()
    }

    
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = viewModel.fetchedResultsController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as! CategoryViewCell
        let category = viewModel.fetchedResultsController.object(at: indexPath)
        cell.configure(by: category)
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let category = viewModel.fetchedResultsController.object(at: indexPath)
//        didSelectCategory?(category)
//        navigationController?.popViewController(animated: true)
    }
    
}

