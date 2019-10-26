//
//  View+CornerRotation.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/26/19.
// ✌️
//

import SwiftUI


extension View {
    
    public func cornerRotation(angle: Angle, anchor: UnitPoint) -> some View {
        self.modifier(CornerRotationModifier(
            angle: angle,
            anchor: anchor
        ))
    }
}
