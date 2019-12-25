//
//  CoffeeCutoffNotice.swift
//  BetterRest
//
//  Created by CypherPoet on 10/21/19.
// ✌️
//

import SwiftUI


struct CoffeeCutoffNotice: View {
    let cutoffTime: Date
}


// MARK: - Body
extension CoffeeCutoffNotice {

    var body: some View {
        
        VStack(spacing: 12.0) {
            Text("Coffee Cutoff Time")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("\(cutoffTime, formatter: DateFormatters.coffeeCutoffTime)")
                .font(.largeTitle)
                .foregroundColor(.pink)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}


// MARK: - Preview
struct CoffeeCutoffNotice_Previews: PreviewProvider {

    static var previews: some View {
        CoffeeCutoffNotice(cutoffTime: Date())
    }
}
