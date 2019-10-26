//
//  CornerRotationModifier.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/26/19.
// ✌️
//

import SwiftUI


struct CornerRotationModifier: ViewModifier {
    let angle: Angle
    let anchor: UnitPoint
    
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(angle, anchor: anchor)
            // Using `clipped()`, the parts that are lying outside the
            // view's natural rectangle don’t get drawn.
            .clipped()
    }
}
