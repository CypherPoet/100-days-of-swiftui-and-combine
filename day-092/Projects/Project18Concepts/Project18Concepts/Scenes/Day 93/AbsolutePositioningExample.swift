//
//  AbsolutePositioningExample.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/24/20.
// ✌️
//

import SwiftUI


struct AbsolutePositioningExample {

}


// MARK: - View
extension AbsolutePositioningExample: View {

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
                .background(Color.red)
                .position(x: 100, y: 100)
            
            
            // 📝 When we use the offset() modifier, we’re changing the location where a view should be
            // rendered without actually changing its underlying geometry.
            //
            // This means when we apply background() afterwards it uses the original position of the
            // text, not its offset.
            //
            // If you move the modifier order so that background() comes before
            // offset() then things work more like you might have expected, showing
            // once again that modifier order matters.
            Text("Hello World!")
                .offset(x: 100, y: -100)
                .background(Color.blue)
            
            Text("Hello World!")
                .background(Color.purple)
                .offset(x: 100, y: -100)
        }
    }
}


// MARK: - Computeds
extension AbsolutePositioningExample {
}


// MARK: - View Variables
extension AbsolutePositioningExample {
}


// MARK: - Private Helpers
private extension AbsolutePositioningExample {
}



// MARK: - Preview
struct AbsolutePositioningExample_Previews: PreviewProvider {

    static var previews: some View {
        AbsolutePositioningExample()
    }
}
