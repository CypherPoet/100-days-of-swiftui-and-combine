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
    
    
    var onTopConversionChanged: (() -> Void)?
    var onBottomConversionChanged: (() -> Void)?
    
    
    var body: some View {
        Group {
            Section(
                header: Text("Temperature Units")
                    .font(.headline)
                    .fontWeight(.semibold)
            ) {
                Picker("First Conversion Unit", selection: $topConversionOption) {
                    ForEach(temperatureOptions, id: \.self) { option in
                        Text(option.shortName)
                    }
                }

                Picker("Second Conversion Unit", selection: $bottomConversionOption) {
                    ForEach(temperatureOptions, id: \.self) { option in
                        Text(option.shortName)
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
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
