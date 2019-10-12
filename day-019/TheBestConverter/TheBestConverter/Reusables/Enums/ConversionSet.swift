//
//  ConversionSet.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/11/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import Foundation
import SwiftUI


enum ConversionSet: CaseIterable {
    case btc
    case temperature
    
    
    var pickerImage: Image {
        switch self {
        case .btc:
            return Image(systemName: "bitcoinsign.circle")
        case .temperature:
            return Image(systemName: "thermometer")
        }
    }
    
    
    var formatter: Formatter {
        switch self {
        case .btc:
            return ConversionOptionFormatter.btcFormatter
        case .temperature:
            return ConversionOptionFormatter.temperatureFormatter
        }
    }
}


struct TemperatureOption: ConversionSetOption, Identifiable, Hashable {
    let id = UUID()
    var unit: UnitTemperature
    
    // MARK: - ConversionSetOption
    var shortName: String
    var fullName: String
    
    
    static var kelvin = TemperatureOption(unit: .kelvin, shortName: "K", fullName: "Kelvin")
    static var celsius = TemperatureOption(unit: .celsius, shortName: "℃", fullName: "Celsius")
    static var fahrenheit = TemperatureOption(unit: .fahrenheit, shortName: "℉", fullName: "Fahrenheit")
}


struct BitcoinOption: ConversionSetOption, Identifiable, Hashable {
    let id = UUID()
    
    // MARK: - ConversionSetOption
    var shortName: String
    var fullName: String
    
    static var btc = BitcoinOption(shortName: "BTC", fullName: "Bitcoin")
    static var satoshi = BitcoinOption(shortName: "SAT", fullName: "Satoshi")
}
