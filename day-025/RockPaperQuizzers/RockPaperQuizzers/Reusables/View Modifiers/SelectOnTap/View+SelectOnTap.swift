//
//  View+SelectOnTap.swift
//  RockPaperQuizzers
//
//  Created by CypherPoet on 10/17/19.
// ✌️
//

import SwiftUI


extension View {
    
    public func selectOnTap(
        borderColor: Color,
        borderWidth: CGFloat = 3.0
    ) -> some View {
        self.modifier(
            SelectOnTap(borderColor: borderColor, borderWidth: borderWidth)
        )
    }
}
