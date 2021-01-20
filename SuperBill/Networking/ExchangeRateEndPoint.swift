//
//  ExchangeRateEndPoint.swift
//  SuperBill
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameter: String { get }
}

struct ExchangeRateEndPoint: EndPointProtocol {
    
    var path = "/live"
    
    var httpMethod: HTTPMethod = .get
    
    var parameter = "&currencies=USD,NZD&format=1"
    
}
