//
//  ColorGradientCycler.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/6/19.
// ✌️
//

import SwiftUI


struct ColorGradientCyclingExample: View {
    @State private var ringCount: CGFloat = 90.0
    @State private var hueStep: CGFloat = 0.2
}


// MARK: - Body
extension ColorGradientCyclingExample {

    var body: some View {
        VStack {
            ColorCyclingCircle(ringCount: Int(ringCount), hueStep: hueStep)
            
            
            circleControls
                .padding()
        }
        .padding(.horizontal)
    }
}


// MARK: - Computeds
extension ColorGradientCyclingExample {


}


// MARK: - View Variables
extension ColorGradientCyclingExample {

    private var circleControls: some View {
        VStack(spacing: 32.0) {
            
            VStack(spacing: 8) {
                Text("Ring Count: \(Int(ringCount))")
                
                Slider(value: $ringCount, in: 1...200, minimumValueLabel: Text("0"), maximumValueLabel: Text("200")) {
                    Text("Ring Count")
                }
                .labelsHidden()
            }
            
            
            VStack(spacing: 8) {
                Text("Hue Step")
                
                Slider(value: $hueStep, in: 0...1, step: 0.01, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Hue Step")
                }
                .labelsHidden()
            }
        }
    }

}



// MARK: - Preview
struct ColorGradientCycler_Previews: PreviewProvider {

    static var previews: some View {
        ColorGradientCyclingExample()
    }
}
