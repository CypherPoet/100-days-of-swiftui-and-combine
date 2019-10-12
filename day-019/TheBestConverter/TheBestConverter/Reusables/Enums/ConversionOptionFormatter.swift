//
//  ConversionOptionFormatter.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/11/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import Foundation


enum ConversionOptionFormatter {
    static let temperatureFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        
        formatter.numberFormatter.usesSignificantDigits = true
        formatter.numberFormatter.maximumSignificantDigits = 4
        formatter.unitOptions = [.providedUnit]
        
        return formatter
    }()
    
    
    static let btcFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 4
        
        return formatter
    }()
}
