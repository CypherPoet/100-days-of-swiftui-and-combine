//
//  VisibilityTransitionExample.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/26/19.
// ✌️
//

import SwiftUI


struct VisibilityTransitionExample: View {
    @State private var isShowingSquare = false
}


// MARK: - Body
extension VisibilityTransitionExample {

    var body: some View {
        
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    self.isShowingSquare.toggle()
                }
            }) {
                Text("Tap Me 🕺")
                    .font(.largeTitle)
            }
            
            if isShowingSquare {
                Rectangle()
                    .fill(Color.pink)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .scale))
            }
        }
    }
}


// MARK: - Preview
struct VisibilityTransitionExample_Previews: PreviewProvider {

    static var previews: some View {
        VisibilityTransitionExample()
    }
}
