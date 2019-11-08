//
//  ScreenedCirclesExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/6/19.
// ✌️
//

import SwiftUI


struct ScreenedCirclesExample: View {
    @State private var circleOffsetAmount: CGFloat = 1.0
}


// MARK: - Body
extension ScreenedCirclesExample {

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 200 * circleOffsetAmount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 200 * circleOffsetAmount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 200 * circleOffsetAmount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            
            Slider(value: $circleOffsetAmount, in: 0...1)
                .accessibility(label: Text("Change the circle offset amount"))
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.black)
    }
}


// MARK: - Computeds
extension ScreenedCirclesExample {


}


// MARK: - View Variables
extension ScreenedCirclesExample {
    
}



// MARK: - Preview
struct ScreenedCirclesExample_Previews: PreviewProvider {

    static var previews: some View {
        ScreenedCirclesExample()
    }
}
