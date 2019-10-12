import UIKit


typealias Satoshi = Decimal


extension Satoshi {
    
    init(fromBTC btc: Decimal) {
        self = btc * Decimal(100_000_000)
    }
}


let sats = Satoshi(fromBTC: 2)

print(sats)
