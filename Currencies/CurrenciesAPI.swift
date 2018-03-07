//
//  CurrenciesAPI.swift
//  Currencies
//
//  Created by Jakub Hutny on 16.12.2016.
//  Copyright © 2016 Jakub Hutny. All rights reserved.
//

import Alamofire
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class CurrenciesAPI: CurrenciesProtocol {
    private let baseURL = "https://api.fixer.io/"
    var currencies = [Currency]()
    var quotationDate = ""
    
//    func fetchCurrencies(completionHandler: @escaping ([Currency], String) -> Void) {
//        let route = baseURL + "/latest"
//        makeHTTPGetRequest(path: route, completionHandler: { json, err in
//            if let results = json["rates"].dictionary {
//                self.quotationDate = json["date"].stringValue
//                for entry in results {
//                    self.currencies.append(Currency(name: entry.key, value: Double(entry.value.stringValue)!))
//                }
//                self.currencies.append(Currency(name: "EUR", value: 1.00))
//                self.currencies.sort { (firstCurrency, secondCurrency) in return firstCurrency.name < secondCurrency.name }
//            }
//            completionHandler(self.currencies, self.quotationDate)
//        })
//    }
    
    func fetchCurrencies(completionHandler: @escaping ([Currency], String) -> Void) {
        let route = baseURL + "/latest"
        
        Alamofire.request(route).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                if let results = json["rates"].dictionary {
                    self.quotationDate = json["date"].stringValue
                    for entry in results {
                        self.currencies.append(Currency(name: entry.key, value: Double(entry.value.stringValue)!))
                    }
                    self.currencies.append(Currency(name: "EUR", value: 1.00))
                    self.currencies.sort { (firstCurrency, secondCurrency) in return firstCurrency.name < secondCurrency.name }
                }
                completionHandler(self.currencies, self.quotationDate)
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func getCurrency(with name: String) -> Currency {
        let foundCurrency = currencies.first(where: { $0.name == name })
        
        return foundCurrency!
    }
    
    // MARK: Perform a GET Request
    
    private func makeHTTPGetRequest(path: String, completionHandler: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                completionHandler(json, error as NSError?)
            } else {
                completionHandler(JSON.null, error as NSError?)
            }
        })
        task.resume()
    }
}
