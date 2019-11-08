//
//  AnimatableDataExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//

import SwiftUI


struct AnimatableDataExample: View {
    @State private var insetAmount: CGFloat = 10.0
}


// MARK: - Body
extension AnimatableDataExample {

    var body: some View {
        VStack {
            Trapezoid(insetAmount: insetAmount)
                .frame(width: 300, height: 200)
                .animation(.easeInOut(duration: 0.3))
            
            
            Slider(value: $insetAmount, in: 0...200)
                .accessibility(label: Text("Change the trapezoid inset amount"))
                .padding()
        }
    }
}



// MARK: - Preview
struct AnimatableDataExample_Previews: PreviewProvider {

    static var previews: some View {
        AnimatableDataExample()
    }
}
