//
//  Router.swift
//  SuperBill
//
//  Created by William Hu on 5/5/20.
//  Copyright © 2020 William Hu. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()

class Router {
    
    private var task: URLSessionTask?
    private let currencyAPIKey = "36b0e345ffc4462050d474c59ea730fe" //If this key is sensitive, then can be use AES + keychain
    private let urlString = "http://api.currencylayer.com" // Should be setup different environment
    
    func cancel() {
        task?.cancel()
    }
    
    func request(endPoint: EndPointProtocol, completion: @escaping NetworkRouterCompletion) {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 8.0
        config.timeoutIntervalForResource = 10.0
        let session = URLSession(configuration: config)
        guard var urlComponents = URLComponents(string: urlString) else {
            return
        }
        urlComponents.path = endPoint.path
        urlComponents.query = "access_key=" + currencyAPIKey + endPoint.parameter
        
        guard let url = urlComponents.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.httpMethod.rawValue
        task = (session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let data = data else {
                    completion(nil, response, error)
                    return
                }
                completion(data, response, nil)
            }
        })
        task!.resume()
    }
    
}
