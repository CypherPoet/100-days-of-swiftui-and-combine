//
//  BasicLongPressGestureExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/16/20.
// ✌️
//

import SwiftUI


struct BasicLongPressGestureExample {
}


// MARK: - View
extension BasicLongPressGestureExample: View {

    var body: some View {
        // 🔑
        // 1) As soon as you press down the change closure will
        //    be called with its parameter set to true.
        //
        // 2) If you release before the gesture has been recognized
        //    (so, if you release after 1 second when using a 2-second recognizer),
        //    the change closure will be called with its parameter set to false.
        //
        // 3) If you hold down for the full length of the recognizer, then the change
        //    closure will be called with its parameter set to false (because the
        //    gesture is no longer in flight),
        //    and your completion closure will be called too.
        Text("Long Press Gestures")
            .onLongPressGesture(
                minimumDuration: 3,
                maximumDistance: .infinity,
                pressing: { (isPressing) in
                    print("Is Pressing: \(isPressing)")
                },
                perform: {
                    print("Performing long press action")
                }
            )
    }
}


// MARK: - Preview
struct GesturesExample_Previews: PreviewProvider {

    static var previews: some View {
        BasicLongPressGestureExample()
    }
}
