//
//  View+stacked.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI


extension View {

    public func stacked(
        at position: Int,
        outOf stackSize: Int,
        offsetMultiple: CGFloat = 10.0
    ) -> some View {
        modifier(
            Stacked(
                position: position,
                stackSize: stackSize,
                offsetMultiple: offsetMultiple
            )
        )
    }

}
