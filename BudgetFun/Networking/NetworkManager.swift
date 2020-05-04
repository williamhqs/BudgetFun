//
//  NetworkManager.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

//http://api.currencylayer.com/live?access_key=36b0e345ffc4462050d474c59ea730fe&currencies=USD,NZD&format=1
struct NetworkManager {
    
    private let router = Router()
    
    func requestCurrencyRate(completion: @escaping (Exchange?) -> Void) {
        let endPoint = ExchangeRateEndPoint()
        router.request(endPoint: endPoint) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            do {
                let exchage = try JSONDecoder().decode(Exchange.self, from: data)
                completion(exchage)
            } catch {
                completion(nil)
            }
        }
    }
}

