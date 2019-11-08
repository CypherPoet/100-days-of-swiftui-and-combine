//
//  ColorCyclingRectangle.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/8/19.
// ✌️
//

import SwiftUI
import Clamping


struct ColorCyclingRectangle: View {

    @Clamping(range: 1...Int.max)
    var layerCount: Int = 10
    
    @Clamping(range: 0...1)
    var hueStep: CGFloat = 0.2
    
    var gradientStartPoint = UnitPoint(x: 0.5, y: 0.0)
    var gradientEndPoint = UnitPoint(x: 0.5, y: 1.0)
}


// MARK: - Body
extension ColorCyclingRectangle {

    var body: some View {
        ZStack {
            ForEach(0 ..< layerCount, id: \.self) { layerIndex in
                Rectangle()
                    .inset(by: CGFloat(layerIndex))
                    .strokeBorder(self.borderGradient(for: layerIndex))
            }
        }
    }
}


// MARK: - Computeds
extension ColorCyclingRectangle {


}

// MARK: - Private Helpers
extension ColorCyclingRectangle {
    
    func hue(for layerIndex: Int) -> Double {
        let steppedHue = (Double(layerIndex) / Double(layerCount)) + Double(hueStep)
        
        return steppedHue.truncatingRemainder(dividingBy: 1)
    }
    
    
    func color(for layerIndex: Int, saturation: Double = 1, brightness: Double = 1) -> Color {
        Color(
            hue: hue(for: layerIndex),
            saturation: saturation,
            brightness: brightness
        )
    }
    
    
    func borderGradient(for layerIndex: Int) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    color(for: layerIndex),
                    color(for: layerIndex, brightness: 0),
                ]
            ),
            startPoint: gradientStartPoint,
            endPoint: gradientEndPoint
        )
    }
}


// MARK: - View Variables
extension ColorCyclingRectangle {


}



// MARK: - Preview
struct ColorCyclingRectangle_Previews: PreviewProvider {

    static var previews: some View {
        ColorCyclingRectangle(layerCount: 100, hueStep: 0.02)
            .drawingGroup()
    }
}
