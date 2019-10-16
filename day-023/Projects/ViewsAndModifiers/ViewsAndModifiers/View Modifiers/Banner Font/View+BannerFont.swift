//
//  View+BannerFont.swift
//  ViewsAndModifiers
//
//  Created by CypherPoet on 10/16/19.
// ✌️
//

import Foundation
import SwiftUI


extension View {
    
    func bannerFont(baseSize: CGFloat = 92) -> some View {
        self.modifier(BannerFont(baseSize: baseSize))
    }
}
