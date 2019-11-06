//
//  ColorCyclingCircle.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/6/19.
// ✌️
//

import SwiftUI
import Clamping


struct ColorCyclingCircle: View {
    
    @Clamping(range: 1...Int.max)
    var ringCount: Int = 10
    
    @Clamping(range: 0...1)
    var hueStep: CGFloat = 0.2
}


// MARK: - Body
extension ColorCyclingCircle {

    var body: some View {
        ZStack {
            ForEach(0 ..< ringCount, id: \.self) { ringIndex in
                Circle()
                    .inset(by: CGFloat(ringIndex))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                self.color(for: ringIndex, brightness: 1),
                                self.color(for: ringIndex, brightness: 0.2),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
}


// MARK: - Private Helpers
private extension ColorCyclingCircle {
    
    func hue(for ringIndex: Int) -> Double {
        ( (Double(ringIndex) / Double(ringCount)) + Double(hueStep) ).truncatingRemainder(dividingBy: 1)
    }
    
    
    func color(for ringIndex: Int, brightness: Double = 1, saturation: Double = 1) -> Color {
        Color(
            hue: hue(for: ringIndex),
            saturation: saturation,
            brightness: brightness
        )
    }

}


// MARK: - View Variables
extension ColorCyclingCircle {


}



// MARK: - Preview
struct ColorCyclingCircle_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            ColorCyclingCircle(ringCount: 100, hueStep: 0.02)
            ColorCyclingCircle(ringCount: 100, hueStep: 0.2)
            ColorCyclingCircle(ringCount: 100, hueStep: 0.4)
            ColorCyclingCircle(ringCount: 100, hueStep: 1)
        }
    }
}
