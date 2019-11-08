//
//  SpirographExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//

import SwiftUI


struct SpirographExample: View {
    @State private var majorRadius: CGFloat = 125.0
    @State private var minorRadius: CGFloat = 75.0
    @State private var penOffset: CGFloat = 25.0
    @State private var amonuntToDraw: CGFloat = 1.0
    @State private var hue: CGFloat = 0.17
}


// MARK: - Body
extension SpirographExample {

    var body: some View {
        VStack {
            Spirograph(
                majorRadius: majorRadius,
                minorRadius: minorRadius,
                penOffset: penOffset,
                amount: amonuntToDraw
            )
                .stroke(currentStrokeColor, lineWidth: 1)
                .drawingGroup()
            
            controls
                .padding()
        }
    }
}


// MARK: - Computeds
extension SpirographExample {

    var currentStrokeColor: Color {
        Color(hue: Double(hue), saturation: 1, brightness: 1)
    }
}


// MARK: - View Variables
extension SpirographExample {

    private var controls: some View {
        VStack(spacing: 22.0) {
            
            VStack(spacing: 8) {
                Text("Major Radius: \(Int(majorRadius))")
                
                Slider(value: $majorRadius, in: 1...250, step: 1.0, minimumValueLabel: Text("1"), maximumValueLabel: Text("250")) {
                    Text("Major Radius")
                }
            }
        
            VStack(spacing: 8) {
                Text("Minor Radius: \(Int(minorRadius))")
                
                Slider(value: $minorRadius, in: 1...150, step: 1.0, minimumValueLabel: Text("1"), maximumValueLabel: Text("150")) {
                    Text("Minor Radius")
                }
            }
            
            VStack(spacing: 8) {
                Text("Pen Offset Distance: \(Int(penOffset))")
                
                Slider(value: $penOffset, in: 1...100, step: 1.0, minimumValueLabel: Text("1"), maximumValueLabel: Text("100")) {
                    Text("Pen Offset Distance")
                }
            }
            
            VStack(spacing: 8) {
                Text("Amount To Draw: \(amonuntToDraw, specifier: "%.2f")")
                
                Slider(value: $amonuntToDraw, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Amount To Draw")
                }
            }
            
            VStack(spacing: 8) {
                Text("Hue: \(hue, specifier: "%.2f")")
                
                Slider(value: $hue, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
                    Text("Hue")
                }
            }
        }
        .labelsHidden()
        .font(.callout)
    }

}



// MARK: - Preview
struct SpirographExample_Previews: PreviewProvider {

    static var previews: some View {
        SpirographExample()
    }
}
