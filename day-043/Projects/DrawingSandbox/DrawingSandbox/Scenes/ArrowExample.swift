//
//  ArrowExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//

import SwiftUI


struct ArrowExample: View {
    @State private var arrowBaseWidthPercentage: CGFloat = 0.5
    @State private var arrowBaseHeightPercentage: CGFloat = 0.67
}


// MARK: - Body
extension ArrowExample {

    var body: some View {
        VStack(spacing: 24.0) {
            Arrow(
                baseWidthPct: arrowBaseWidthPercentage,
                baseHeightPct: arrowBaseHeightPercentage
            )
                .animation(.easeInOut(duration: 0.8))
            
            controls
                .padding(.vertical)
        }
        .padding()
        .navigationBarTitle("Custom Arrow Shape")
    }
}


// MARK: - Computeds
extension ArrowExample {


}


// MARK: - View Variables
extension ArrowExample {

    private var controls: some View {
        VStack(spacing: 22.0) {
            
            VStack(spacing: 8) {
                Text("Base Width Percentage: \(Int(arrowBaseWidthPercentage * 100))%")

                Slider(value: $arrowBaseWidthPercentage, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Base Width Percentage")
                }
            }
            
            VStack(spacing: 8) {
                Text("Base Height Percentage: \(Int(arrowBaseHeightPercentage * 100))%")

                Slider(value: $arrowBaseHeightPercentage, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Base Height Percentage")
                }
            }
        }
        .labelsHidden()
    }
}



// MARK: - Preview
struct ArrowExample_Previews: PreviewProvider {

    static var previews: some View {
        ArrowExample()
    }
}
