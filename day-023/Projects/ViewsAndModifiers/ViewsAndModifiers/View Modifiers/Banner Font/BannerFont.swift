//
//  BannerFont.swift
//  ViewsAndModifiers
//
//  Created by CypherPoet on 10/16/19.
// ✌️
//

import Foundation
import SwiftUI


struct BannerFont: ViewModifier {
    let baseSize: CGFloat
    
    /// We don't use this, but the declaration here
    /// asks the system to update the view when it changes
    @Environment(\.sizeCategory) var sizeCategory
    
    
    init(baseSize: CGFloat = 92) {
        self.baseSize = baseSize
    }
    
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: 88)
        
        return content
            .font(.system(size: scaledSize))
            .foregroundColor(.blue)
    }
}


// We could take this even further by having a separate modifier handle
// dynamic sizing (See: https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-dynamic-type-with-a-custom-font)
