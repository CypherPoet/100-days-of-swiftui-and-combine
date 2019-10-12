//
//  TemperatureSegmentControls.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/12/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI

struct TemperatureSegmentControls: View {
    var temperatureOptions: [TemperatureOption]
    
    @Binding var topConversionOption: TemperatureOption
    @Binding var bottomConversionOption: TemperatureOption
    
    
    var body: some View {
        Group {
            Section(
                header: Text("Convert...")
                    .font(.headline)
                    .fontWeight(.semibold)
            ) {
                Picker("Conversion 1", selection: $topConversionOption) {
                    ForEach(temperatureOptions, id: \.self) { option in
                        Text(option.shortName)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            
            Section(
                header: Text("To...")
                    .font(.headline)
                    .fontWeight(.semibold)
            ) {
                Picker("Conversion 1", selection: $bottomConversionOption) {
                    ForEach(temperatureOptions, id: \.self) { option in
                        Text(option.shortName)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}



struct TemperatureSegmentControls_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureSegmentControls(
            temperatureOptions: [.kelvin, .celsius, .fahrenheit],
            topConversionOption: .constant(.kelvin),
            bottomConversionOption: .constant(.kelvin)
        )
    }
}
