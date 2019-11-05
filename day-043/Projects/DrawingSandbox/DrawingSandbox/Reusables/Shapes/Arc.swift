//
//  Arc.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/5/19.
// ✌️
//

import SwiftUI


struct Arc {
    let startAngle: Angle
    let endAngle: Angle
    let isClockwise: Bool
    let startsFromTop: Bool
    
    private let rotationAdjustment = Angle(radians: .pi / 2)
    
    /// Add to this whenever `inset(by:)` is called so we can  properly
    /// support the use of the `strokeBorder modifier`.
    var insetAmount: CGFloat = 0.0
    

    init(
        startAngle: Angle,
        endAngle: Angle,
        isClockwise: Bool = false,
        startsFromTop: Bool = false
    ) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.isClockwise = isClockwise
        self.startsFromTop = startsFromTop
    }
}


// MARK: -  Computeds
extension Arc {
    
    var modifiedStartAngle: Angle {
        startsFromTop ? startAngle - rotationAdjustment : startAngle
    }
    
    var modifiedEndAngle: Angle {
        startsFromTop ? endAngle - rotationAdjustment : endAngle
    }
}


// MARK: -  Shape
extension Arc: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: (min(rect.width, rect.height) / 2) - insetAmount,
            startAngle: modifiedStartAngle,
            endAngle: modifiedEndAngle,
            clockwise: !isClockwise
        )
        
        return path
    }
}


// MARK: -  InsettableShape
extension Arc: InsettableShape {

    func inset(by amount: CGFloat) -> some InsettableShape {
        var newArc = self
        
        newArc.insetAmount += amount
        
        return newArc
    }
}
