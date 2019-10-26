//
//  PivotTransition.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/26/19.
// ✌️
//

import SwiftUI


extension AnyTransition {
    
    public static var pivot: AnyTransition {
        .modifier(
            active: CornerRotationModifier(angle: .radians(-.pi / 2), anchor: .topLeading),
            identity: CornerRotationModifier(angle: .radians(0), anchor: .topLeading)
        )
    }
}
