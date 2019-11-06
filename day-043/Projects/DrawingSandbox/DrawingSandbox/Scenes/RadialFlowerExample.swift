//
//  RadialFlowerExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/5/19.
// ✌️
//

import SwiftUI


struct RadialFlowerExample: View {
    @State private var petalWidth: CGFloat = 100.0
    @State private var petalCount: Int = 16
    @State private var petalOffset: CGFloat = 20.0
}



// MARK: - Body
extension RadialFlowerExample {

    var body: some View {
        VStack {
            RadialFlower(petalWidth: petalWidth, petalCount: petalCount, petalOffset: petalOffset)
                .fill(Color.pink, style: FillStyle(eoFill: true, antialiased: true))
            
            petalControls
                .padding()
        }
        .padding(.horizontal)
    }
}



// MARK: - Computeds
extension RadialFlowerExample {
    
    
}


// MARK: - View Variables
extension RadialFlowerExample {

    private var petalControls: some View {
        VStack(spacing: 22.0) {
            
            Stepper(value: $petalCount, in: 4...24) {
                HStack {
                    Text("Petal Count")
                    Spacer()
                    Text("\(petalCount)")
                }
            }
            
            VStack(spacing: 8) {
                Text("Petal Width")
                
                Slider(value: $petalWidth, in: 0...100, minimumValueLabel: Text("0"), maximumValueLabel: Text("100")) {
                    Text("Petal Width")
                }
                .labelsHidden()
            }
        
            VStack(spacing: 8) {
                Text("Petal Offset")
                
                Slider(value: $petalOffset, in: -40.0...40.0, minimumValueLabel: Text("-40"), maximumValueLabel: Text("40")) {
                    Text("Petal Offset")
                }
                .labelsHidden()
            }
        }
    }
}



// MARK: - Preview
struct RadialFlowerExample_Previews: PreviewProvider {

    static var previews: some View {
        RadialFlowerExample()
    }
}
