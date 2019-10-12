//
//  TemperatureConversionView.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/12/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI

struct TemperatureConversionView: View {
    private var temperatureOptions: [TemperatureOption] = [
        .kelvin,
        .celsius,
        .fahrenheit,
    ]
    
    @State private var topConversionOption: TemperatureOption = .kelvin
    @State private var bottomConversionOption: TemperatureOption = .celsius
    

    var body: some View {
        
        Form {
            TemperatureSegmentControls(
                temperatureOptions: temperatureOptions,
                topConversionOption: $topConversionOption,
                bottomConversionOption: $bottomConversionOption
            )
            
            TemperatureInputs(
                topConversionOption: $topConversionOption,
                bottomConversionOption: $bottomConversionOption
            )
        }
        .keyboardType(.numberPad)
    }
}

struct TemperatureConversionView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConversionView()
    }
}
