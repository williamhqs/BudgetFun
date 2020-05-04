//
//  AddTransactionViewModel.swift
//  BudgetFun
//
//  Created by William Hu on 4/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

final class AddTransactionViewModel {
    
    init() {
        getCurrencyRate()
    }
    
    var currencySegmentTitles: [String] {
        return Currency.allCases.map { $0.rawValue }
    }
    
    var selectedCategory: Category?
    var inputAmount: Decimal?
    
    var currency: Currency = .USD
    
    var currecyRate: Double?
    
    var selectedCurrecyIndex: Int = 0 {
        didSet {
            currency = Currency.allCases[selectedCurrecyIndex]
        }
    }
    
    func calculateCurrency(_ amount: Decimal) -> String {
        
        guard let rate = currecyRate, rate != 0 else {
            return ""
        }
        if currency == .USD {
            return Decimal(Double(truncating: amount as NSNumber) / rate).currency
        } else {
            return Decimal(Double(truncating: amount as NSNumber) * rate).currency
        }
    }
    
    private func getCurrencyRate () {
        reqest { [weak self] (data, response, error) in
            guard let self = self else { return }
            self.currecyRate = data?.quote(targetCurrency: .NZD)
        }
    }
    
    func add() {
        
        guard let category = selectedCategory else {
            #warning("Validate alert, category can't be nil")
            return
        }
        
        guard let amount = inputAmount else {
            #warning("Validate alert, inputAmount can't be nil")
            return
        }

        let coreDataManager = CoreDataManager()
        let context = coreDataManager.newBackgroundContext()
        let trasaction = coreDataManager.create(Transaction.self, in: context)
        do {
            let c = try context.existingObject(with: category.objectID) as? Category
            trasaction?.category = c
            trasaction?.amount = amount as NSDecimalNumber
            trasaction?.currenceType = currency.rawValue
            trasaction?.createdAt = Date()
        } catch {
            
        }
        
        context.perform {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func reqest(completion: @escaping RequestCompletion) {
        //        guard var request = self.buildRequest(from: route) else {
        //            print("Build request error")
        //            return
        //        }
        //        if let route = route as? GoalAlleEndPoint, let urlParamter = route.urlParameters {
        //            try? URLParameterEncoder().encode(urlRequest: &request, with: urlParamter)
        //        }
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 8.0
        config.timeoutIntervalForResource = 10.0
        let session = URLSession(configuration: config)
        guard var urlComponents = URLComponents(string: "http://api.currencylayer.com/live") else {
            return
        }
        urlComponents.query = "access_key=36b0e345ffc4462050d474c59ea730fe&currencies=USD,NZD&format=1"
        
        guard let url = urlComponents.url else {
            return
        }
        let request = URLRequest(url: url)
        
        (session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let data = data else {
                    completion(nil, response, error)
                    return
                }
                
                do {
                    let exchage = try JSONDecoder().decode(Exchange.self, from: data)
                    completion(exchage, response, nil)
                } catch {
                    print(error)
                }
            }
        }).resume()
    }
}
