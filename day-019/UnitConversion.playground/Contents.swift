
import Foundation
import SwiftUI



protocol ConversionSetOption {
    var shortName: String { get }
    var fullName: String { get }
    
//    var formatter: Formatter { get }
}


enum ConversionSet: CaseIterable {
    case btc
    case temperature
}


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



extension ConversionSet {
    
    struct TemperatureOption: ConversionSetOption {
        var unit: UnitTemperature
        
        // MARK: - ConversionSetOption
        var shortName: String
        var fullName: String
//        var formatter: Formatter { ConversionOptionFormatter.temperatureFormatter }
    }
    
    
    struct BitcoinOption: ConversionSetOption {
        // MARK: - ConversionSetOption
        var shortName: String
        var fullName: String
//        var formatter: Formatter { ConversionOptionFormatter.btcFormatter }
    }
}


extension ConversionSet {
    
    var pickerImage: Image {
        Image(systemName: "star")
    }
    
    
    var formatter: Formatter {
        switch self {
        case .btc:
            return ConversionOptionFormatter.btcFormatter
        case .temperature:
            return ConversionOptionFormatter.temperatureFormatter
        }
    }
    
    
    var options: [ConversionSetOption] {
        switch self {
        case .btc:
            return [
                BitcoinOption(shortName: "BTC", fullName: "Bitcoin"),
                BitcoinOption(shortName: "SAT", fullName: "Satoshis"),
            ]
        case .temperature:
            return [
                TemperatureOption(unit: UnitTemperature.kelvin, shortName: "K", fullName: "Kelvin"),
                TemperatureOption(unit: UnitTemperature.celsius, shortName: "℃", fullName: "Celsius"),
                TemperatureOption(unit: UnitTemperature.fahrenheit, shortName: "℉", fullName: "Fahrenheit"),
            ]
        }
    }
}


let conversionSet = ConversionSet.temperature
let kelvinOption = conversionSet.options[0]

let celsius = Measurement<UnitTemperature>(value: 2, unit: .celsius)
let fahrenheit = Measurement<UnitTemperature>(value: 32, unit: .fahrenheit)

//kelvinOption.formatter.string(for: celsius)
//kelvinOption.formatter.string(for: fahrenheit)

conversionSet.formatter.string(for: celsius)
conversionSet.formatter.string(for: fahrenheit)
