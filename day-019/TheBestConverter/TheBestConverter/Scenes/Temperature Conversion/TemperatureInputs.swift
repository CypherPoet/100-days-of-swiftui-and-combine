//
//  TemperatureInputs.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/12/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI

struct TemperatureInputs: View {
    @Binding var topConversionOption: TemperatureOption
    @Binding var bottomConversionOption: TemperatureOption
    
    @State private var topConversionText: String = "0"
    @State private var bottomConversionText: String = "0"
    
    
    var body: some View {
        Group {
            Section(
                header: Text(topConversionOption.fullName)
                    .fontWeight(.bold)
            ) {
                TextField(
                    topConversionOption.fullName,
                    text: $topConversionText,
                    onEditingChanged: { _ in self.topConversionInputChanged() }
                )
                    .frame(height: 64)
                    .font(.title)
            }

            Section(
                header: Text(bottomConversionOption.fullName)
                    .fontWeight(.bold)
            ) {
                TextField(
                    bottomConversionOption.fullName,
                    text: $bottomConversionText,
                    onEditingChanged: { _ in self.bottomConversionInputChanged() }
                )
                    .frame(height: 64)
                    .font(.title)
            }
        }
    }
}


// MARK: - Computeds
extension TemperatureInputs {
    
    private var topConversionValue: Measurement<UnitTemperature>? {
        guard let topConversionNumber = Double(topConversionText) else { return nil }

        return Measurement<UnitTemperature>(
            value: topConversionNumber,
            unit: topConversionOption.unit
        )
    }
    
    private var bottomConversionValue: Measurement<UnitTemperature>? {
        guard let bottomConversionNumber = Double(bottomConversionText) else { return nil }

        return Measurement<UnitTemperature>(
            value: bottomConversionNumber,
            unit: bottomConversionOption.unit
        )
    }
}


// MARK: - Change Handling
extension TemperatureInputs {
        
    private func topConversionInputChanged() {
        guard let topConversionValue = topConversionValue else {
            bottomConversionText = "N/A"
            return
        }
        
        let formatter = ConversionOptionFormatter.temperatureFormatter
        
        bottomConversionText = formatter.string(
            from: topConversionValue.converted(to: bottomConversionOption.unit)
        )
    }
    
    
    private func bottomConversionInputChanged() {
        guard let bottomConversionValue = bottomConversionValue else {
            topConversionText = "N/A"
            return
        }
        
        let formatter = ConversionOptionFormatter.temperatureFormatter
        
        topConversionText = formatter.string(
            from: bottomConversionValue.converted(to: topConversionOption.unit)
        )
    }
}


struct TemperatureInputs_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureInputs(
            topConversionOption: .constant(.kelvin),
            bottomConversionOption: .constant(.celsius)
        )
    }
}
