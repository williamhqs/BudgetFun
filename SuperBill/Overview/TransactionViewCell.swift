//
//  TransactionViewCell.swift
//  SuperBill
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import UIKit

class TransactionViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var categoryColorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryColorView.layer.cornerRadius = 5.0
    }
    
    func configure(by transaction: Transaction) {
        
        guard let amount = transaction.amount, let type = transaction.currenceType else {
            return
        }
        amountLabel.text = type + amount.stringValue
        categoryNameLabel.text = transaction.category?.name?.localized
        categoryColorView.backgroundColor = transaction.category?.color as? UIColor
        createdAtLabel.text = transaction.createdAt?.timestampString?.localized
        
    }
    
    func draw(_ text: String, _ rect: CGRect, _ font: UIFont) {

           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.alignment = .center
           let attributes = [
               NSAttributedString.Key.paragraphStyle: paragraphStyle,
               NSAttributedString.Key.font: font,
               NSAttributedString.Key.foregroundColor: UIColor.green
           ]
           NSAttributedString(string: text, attributes: attributes).draw(in: rect.insetBy(dx: 0, dy: (rect.height - font.pointSize)/2))
       }
    
}
