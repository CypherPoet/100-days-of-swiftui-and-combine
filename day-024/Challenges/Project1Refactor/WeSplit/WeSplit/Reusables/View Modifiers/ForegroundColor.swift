//
//  ForegroundColor.swift
//  WeSplit
//
//  Created by CypherPoet on 10/16/19.
// ✌️
//

import SwiftUI


struct ForegroundColor: ViewModifier {
    let color: Color
    
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
    }
}
