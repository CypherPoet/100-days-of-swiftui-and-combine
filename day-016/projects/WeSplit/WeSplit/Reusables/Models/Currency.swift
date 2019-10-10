//
//  Currency.swift
//  WeSplit
//
//  Created by Brian Sipple on 10/9/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import Foundation


struct Currency {
    static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 3
        formatter.currencySymbol = ""
        
        return formatter
    }
}
