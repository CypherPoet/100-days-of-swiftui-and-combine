//
//  CornerRotationExample.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/26/19.
// ✌️
//

import SwiftUI


struct CornerRotationExample: View {
    @State private var isShowingRectangle = true
}


// MARK: - Body
extension CornerRotationExample {

    var body: some View {
        
        VStack {
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    self.isShowingRectangle.toggle()
                }
            }) {
                Text("Tap Me 💫")
                    .font(.largeTitle)
            }

            
            if isShowingRectangle {
                Rectangle()
                    .fill(Color.accentColor)
                    .transition(.pivot)
            }
        }
    }
}


// MARK: - Preview
struct CornerRotaionExample_Previews: PreviewProvider {

    static var previews: some View {
        CornerRotationExample()
    }
}
