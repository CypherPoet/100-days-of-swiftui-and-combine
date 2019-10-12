//
//  Satoshi.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/12/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import Foundation

typealias Satoshi = Decimal


extension Satoshi {
    
    init(fromBTC btc: Decimal) {
        self = btc * Decimal(100_000_000)
    }
    
    
    func rounded() -> Satoshi {
        var value = self
        var result: Decimal = 0
        
        NSDecimalRound(&result, &value, 0, .bankers)
        
        return result
    }
    
    
    var int64: Int64 {
        return Int64(truncating: self.rounded() as NSDecimalNumber)
    }
    
    
    var btc: Decimal {
        return self / Decimal(100_000_000)
    }
    
    
}
