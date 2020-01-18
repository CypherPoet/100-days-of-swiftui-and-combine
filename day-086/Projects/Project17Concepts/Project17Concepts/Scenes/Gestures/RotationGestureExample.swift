//
//  RotationGestureExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/16/20.
// ✌️
//

import SwiftUI


struct RotationGestureExample {
//    @GestureState private var rotationState: CGFloat = 1.0
    @State private var rotationAngle: Angle = .zero
}


// MARK: - View
extension RotationGestureExample: View {

    var body: some View {
        VStack {
            Spacer()
            
            Image("paris")
                .resizable()
                .scaledToFit()
                .rotationEffect(rotationAngle)
                .gesture(rotationGesture)
            
            Text("Rotate Me")
                .font(.headline)
            
            Spacer()
        }
        .navigationBarTitle("Rotation")
    }
}


// MARK: - Computeds
extension RotationGestureExample {


}


// MARK: - View Variables
extension RotationGestureExample {

    var rotationGesture: some Gesture {
        RotationGesture()
//            .updating($rotationState) { (rotationValue, state, transaction) in
//                state = rotationValue
//            }
            .onChanged { value in
                self.rotationAngle = value
                print("onChanged || Value: \(value)")
            }
            .onEnded { value in
                print("onEnded || Value: \(value)")
           }
    }
}



// MARK: - Preview
struct RotationGestureExample_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            RotationGestureExample()
        }
    }
}
