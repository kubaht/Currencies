//
//  CurrenciesMemoryStorage.swift
//  Currencies
//
//  Created by Jakub Hutny on 16.12.2016.
//  Copyright © 2016 Jakub Hutny. All rights reserved.
//

import Foundation

class CurrenciesMemoryStorage: CurrenciesProtocol {
    func fetchCurrencies(completionHandler: @escaping ([Currency], String) -> Void) {
        
    }
    
    func getCurrency(with name: String) -> Currency {
        
        return Currency(name: "", value: 0.0)
    }
}
