//
//  CurrenciesWorker.swift
//  Currencies
//
//  Created by Jakub Hutny on 15.12.2016.
//  Copyright © 2016 Jakub Hutny. All rights reserved.
//

import Foundation

protocol CurrenciesProtocol {
    func fetchCurrencies(completionHandler: @escaping (_ currency: [Currency], _ date: String) -> Void)
    func getCurrency(with name: String) -> Currency
}

class CurrenciesWorker {
    var currenciesStore: CurrenciesProtocol
    
    init(currenciesStore: CurrenciesProtocol) {
        self.currenciesStore = currenciesStore
    }
    
    func fetchCurrencies(completionHandler: @escaping (_ currency: [Currency], _ date: String) -> Void) {
        currenciesStore.fetchCurrencies { (currencies: [Currency], date: String) -> Void in
            completionHandler(currencies, date)
        }
    }
    
    func getCurrency(with name: String) -> Currency {
        return currenciesStore.getCurrency(with: name)
    }
}
