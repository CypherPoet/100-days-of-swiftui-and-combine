//
//  TemperatureConversionView.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/12/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI


struct TemperatureConversionView: View {
    @ObservedObject var formData = TemperatureFormData()
    
    
    var body: some View {
        Form {
            TemperatureSegmentControls(
                temperatureOptions: formData.options,
                topConversionOption: $formData.topConversionOption,
                bottomConversionOption: $formData.bottomConversionOption
            )
            
            TemperatureInputs(
                topConversionOption: $formData.topConversionOption,
                bottomConversionOption: $formData.bottomConversionOption,
                topConversionText: $formData.topConversionText,
                bottomConversionText: $formData.bottomConversionText
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
