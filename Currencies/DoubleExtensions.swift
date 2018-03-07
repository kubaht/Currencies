//
//  DoubleExtensions.swift
//  Currencies
//
//  Created by Jakub Hutny on 09.11.2016.
//  Copyright © 2016 Jakub Hutny. All rights reserved.
//

import Foundation

extension Double {
    // Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
