//
//  CurrencyHelper.swift
//  Currencies
//
//  Created by Jakub Hutny on 20.12.2016.
//  Copyright © 2016 Jakub Hutny. All rights reserved.
//

import Foundation
import XCTest
@testable import Currencies

class CurrencyHelper {
    static func compareTwoCurrencies(firstCurrencies: [Currency], secondCurrencies: [Currency]) {
        if (firstCurrencies.count == secondCurrencies.count) {
            for index in 0...(firstCurrencies.count - 1) {
                let firstCurrencyName = firstCurrencies[index].name
                let firstCurrencyValue = firstCurrencies[index].value
                let secondCurrencyName = secondCurrencies[index].name
                let secondCurrencyValue = secondCurrencies[index].value
            
                XCTAssertEqual(firstCurrencyName, secondCurrencyName, createErrorMessage(index: index, propertyName: "name", firstProperty: firstCurrencyName, secondProperty: secondCurrencyName))
                XCTAssertEqual(firstCurrencyValue, secondCurrencyValue, createErrorMessage(index: index, propertyName: "value", firstProperty: String(firstCurrencyValue), secondProperty: String(secondCurrencyValue)))
            }
        }
        else {
            XCTAssert(false, "Currencies has different sizes.")
        }
    }
    
    private static func createErrorMessage(index: Int, propertyName: String, firstProperty: String, secondProperty: String) -> String {
        return "Currency at index " + String(index) + " has " + propertyName + " " + firstProperty + " while expected is " + secondProperty
    }
}
