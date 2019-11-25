//
//  InfoHeaderTextStyle.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/24/19.
// ✌️
//

import SwiftUI


struct InfoHeaderTextStyle: ViewModifier {
    var color: Color = .secondary
    
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(color)
    }
}
