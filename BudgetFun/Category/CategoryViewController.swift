//
//  CategoryViewController.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController {
    
    let viewModel = CategoryViewModel()
    var didSelectCategory: ((Category) -> Void)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fetchedResultsController: NSFetchedResultsController<Category> {
        let fetchedRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchedRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: CoreDataManager().persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return controller
    }
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        viewModel.preloadCategories(context: fetchedResultsController.managedObjectContext)

    }

}

extension CategoryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as! CategoryViewCell
        let category = fetchedResultsController.object(at: indexPath)
        cell.configure(by: category)
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = fetchedResultsController.object(at: indexPath)
        didSelectCategory?(category)
        self.navigationController?.popViewController(animated: true)
    }
}

