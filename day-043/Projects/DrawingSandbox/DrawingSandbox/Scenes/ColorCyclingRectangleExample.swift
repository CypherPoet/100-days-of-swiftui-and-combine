//
//  ColorCyclingRectangleExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/8/19.
// ✌️
//

import SwiftUI


struct ColorCyclingRectangleExample: View {
    @State private var layerCount: CGFloat = 400.0
    @State private var hueStep: CGFloat = 0.2
    @State private var gradientEndX: CGFloat = 0.5
    @State private var gradientEndY: CGFloat = 1.0
}


// MARK: - Body
extension ColorCyclingRectangleExample {

    var body: some View {
        VStack {
            ColorCyclingRectangle(
                layerCount: Int(layerCount),
                hueStep: hueStep,
                gradientEndPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
            )
            .drawingGroup()
            .edgesIgnoringSafeArea(.all)
            
            controls
                .padding()
        }
    }
}


// MARK: - Computeds
extension ColorCyclingRectangleExample {


}


// MARK: - View Variables
extension ColorCyclingRectangleExample {

    private var controls: some View {
        VStack(spacing: 24.0) {
            
            VStack(spacing: 2) {
                Text("Layer Count: \(Int(layerCount))")
                
                Slider(value: $layerCount, in: 1...800, minimumValueLabel: Text("0"), maximumValueLabel: Text("800")) {
                    Text("Layer Count")
                }
            }
            
            VStack(spacing: 2) {
                Text("Hue Step: \(hueStep, specifier: "%.3f")")
                
                Slider(value: $hueStep, in: 0...1, step: 0.001, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Hue Step")
                }
            }

            VStack(spacing: 2) {
                Text("Gradient End X: \(gradientEndX, specifier: "%.3f")")
                
                Slider(value: $gradientEndX, in: 0...1, step: 0.001, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Gradient End X")
                }
            }
            
            VStack(spacing: 2) {
                Text("Gradient End Y: \(gradientEndY, specifier: "%.3f")")
                
                Slider(value: $gradientEndY, in: 0...1, step: 0.001, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Gradient End Y")
                }
            }
        }
        .labelsHidden()
    }
}



// MARK: - Preview
struct ColorCyclingRectangleExample_Previews: PreviewProvider {

    static var previews: some View {
        ColorCyclingRectangleExample()
    }
}
