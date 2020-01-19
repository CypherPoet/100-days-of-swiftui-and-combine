//
//  ReducingMotionExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/18/20.
// ✌️
//

import SwiftUI


func withMotionSensitiveAnimation<Content>(
    _ animation: Animation = .default,
    body: () throws -> Content
) rethrows -> Content {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}


struct ReducingMotionExample {
    @State private var buttonScaleState: ButtonScaleState = .up
}


// MARK: - View
extension ReducingMotionExample: View {

    var body: some View {
        Button(action: {
            withMotionSensitiveAnimation(Animation.easeOut(duration: 0.4)) {
                self.buttonScaleState = self.buttonScaleState == .up ? .down : .up
            }
        }) {
            Text("Scale \(buttonScaleState == .up ? "Down" : "Up")")
                .foregroundColor(.primary)
                .padding()
                .frame(width: 100, height: 100)
        }
        .background(
            Circle()
                .fill(Color.pink)
                .frame(width: 100, height: 100)
        )
        .scaleEffect(buttonScaleState.scaleValue)
    }
}


// MARK: - Computeds
extension ReducingMotionExample {
}


// MARK: - View Variables
extension ReducingMotionExample {
}


// MARK: - Private Helpers
private extension ReducingMotionExample {
}


extension ReducingMotionExample {
    
    private enum ButtonScaleState {
        case up
        case down
        
        var scaleValue: CGFloat {
            switch self {
            case .up:
                return 1.0
            case .down:
                return 0.7
            }
        }
    }
}


// MARK: - Preview
struct ReducingMotionExample_Previews: PreviewProvider {

    static var previews: some View {
        ReducingMotionExample()
    }
}
