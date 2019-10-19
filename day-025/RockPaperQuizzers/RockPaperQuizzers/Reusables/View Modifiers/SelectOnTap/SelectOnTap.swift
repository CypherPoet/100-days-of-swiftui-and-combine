//
//  SelectOnTap.swift
//  RockPaperQuizzers
//
//  Created by CypherPoet on 10/17/19.
// ✌️
//

import SwiftUI


public struct SelectOnTap {
    public let borderColor: Color
    public let borderWidth: CGFloat
    
    @State private var isSelected = false
    
    
    public init(
        borderColor: Color,
        borderWidth: CGFloat = 3.0
    ) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
}


extension SelectOnTap: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? borderColor : .clear, lineWidth: 3.0)
            )
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.isSelected.toggle()
                }
            }
    }
}
