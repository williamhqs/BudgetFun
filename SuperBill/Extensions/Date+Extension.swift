//
//  Date+Extension.swift
//  SuperBill
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

extension Date {
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        return formatter.string(from: self, to: Date())
    }
    
    var individualDayString: String {
        let formater = DateFormatter()
        formater.dateFormat = "d MMMM yyyy"
        return formater.string(from: self)
    }
}
