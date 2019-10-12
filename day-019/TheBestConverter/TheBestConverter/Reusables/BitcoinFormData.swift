//
//  BitcoinFormData.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/12/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import Foundation
import Combine


final class BitcoinFormData: ObservableObject {
    @Published var btcConversionText: String = "1" {
        didSet { btcConversionValueChanged() }
    }
    
    @Published var satoshiConversionText: String = "0" {
        didSet { satoshiConversionValueChanged() }
    }
}

// MARK: - Computeds
extension BitcoinFormData {
    private var btcConversionValue: Decimal? { Decimal(string: btcConversionText) }
    private var satoshiConversionValue: Satoshi? { Satoshi(string: satoshiConversionText) }
}


// MARK: - Change Handling
extension BitcoinFormData {
        
    private func btcConversionValueChanged() {
        let expectedSatoshiText = btcConversionValue != nil ?
            "\(Satoshi(fromBTC: btcConversionValue!))"
            :
            "N/A"
        
        if satoshiConversionText != expectedSatoshiText {
            satoshiConversionText = expectedSatoshiText
        }
    }
    
    
    private func satoshiConversionValueChanged() {
        let expectedBTCText = satoshiConversionValue != nil ?
            "\(satoshiConversionValue!.btc)"
            :
            "N/A"
        
        if btcConversionText != expectedBTCText {
            btcConversionText = expectedBTCText
        }
    }
}
