//
//  CalculateExchangeRateWorker.swift
//  Currencies
//
//  Created by Jakub Hutny on 14.12.2016.
//  Copyright (c) 2016 Jakub Hutny. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class CalculateExchangeRateWorker
{
  // MARK: - Business Logic
    
    var InputLabelName: String {
        get {
            return "Input"
        }
    }
    
    var OutputLabelName: String {
        get {
            return "Output"
        }
    }
    
    func calculateResult(isOnStart: Bool, inputRate: Double = 1.0, outputRate: Double = 1.0, amount: Double = 1.0) -> Double {
        var result: Double
        if isOnStart {
            result = 0.00
        }
        else {
            let rate = outputRate / inputRate
            result = amount * rate
        }
        
        return result
    }
}
