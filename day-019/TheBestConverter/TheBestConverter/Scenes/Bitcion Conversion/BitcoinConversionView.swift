//
//  BitcoinConversionView.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/11/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI

struct BitcoinConversionView: View {
    @State private var baseUnit: ConversionSetOption = BitcoinOption(shortName: "BTC", fullName: "Bitcion")
    
    @State private var currentBTCString: String = ""
    @State private var currentSatoshisString: String = ""
    
    private var conversionResult: ConversionSetOption = BitcoinOption(shortName: "SAT", fullName: "Satoshis")
    

    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Form {
                    Section(
                        header:
                            Text("Bitcoin")
                                .font(.headline)
                                .fontWeight(.bold)
                    ) {
                        TextField("Amount in BTC", text: $currentBTCString)
                    }
                    
                    Section(
                        header:
                            Text("Satoshis")
                                .font(.headline)
                                .fontWeight(.bold)
                    ) {
                        TextField("Amount in SAT", text: $currentBTCString)
                    }
                }
            }
        }
    }
}

struct BitcoinConversionView_Previews: PreviewProvider {
    static var previews: some View {
        BitcoinConversionView()
    }
}
