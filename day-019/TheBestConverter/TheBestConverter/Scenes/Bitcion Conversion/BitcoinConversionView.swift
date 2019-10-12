//
//  BitcoinConversionView.swift
//  TheBestConverter
//
//  Created by Brian Sipple on 10/11/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI

struct BitcoinConversionView: View {
    @ObservedObject var bitcoinFormData = BitcoinFormData()
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Form {
                    Section(
                        header:
                        Text(BitcoinOption.btc.fullName)
                                .font(.headline)
                                .fontWeight(.bold)
                    ) {
                        TextField("Amount in BTC", text: $bitcoinFormData.btcConversionText)
                    }
                    
                    Section(
                        header:
                            Text(BitcoinOption.satoshi.fullName)
                                .font(.headline)
                                .fontWeight(.bold)
                    ) {
                        TextField("Amount in SAT", text: $bitcoinFormData.satoshiConversionText)
                    }
                }
                .keyboardType(.numberPad)
            }
        }
        .onAppear {
            self.bitcoinFormData.btcConversionText = "1"
        }
    }
}

struct BitcoinConversionView_Previews: PreviewProvider {
    static var previews: some View {
        BitcoinConversionView()
    }
}
