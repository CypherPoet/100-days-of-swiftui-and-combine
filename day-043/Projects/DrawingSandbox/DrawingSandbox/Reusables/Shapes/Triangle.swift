//
//  Triangle.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/5/19.
// ✌️
//

import SwiftUI


struct Triangle {

    /// Add to this whenever `inset(by:)` is called so we can  properly
    /// support the use of the `strokeBorder modifier`.
    var insetAmount: CGFloat = 0.0
}


// MARK: - Shape
extension Triangle: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: topPoint(in: rect))
        
        path.addLine(to: bottomRightPoint(in: rect))
        path.addLine(to: bottomLeftPoint(in: rect))
        path.addLine(to: topPoint(in: rect))
        
        return path
    }
}



// MARK: -  InsettableShape
extension Triangle: InsettableShape {

    func inset(by amount: CGFloat) -> some InsettableShape {
        var newShape = self
        
        newShape.insetAmount += amount
        
        return newShape
    }
}



// MARK: - Private Helpers
extension Triangle {
    
    private func topPoint(in rect: CGRect) -> CGPoint {
        CGPoint(x: rect.midX, y: rect.minY)
    }
    
    private func bottomLeftPoint(in rect: CGRect) -> CGPoint {
        CGPoint(x: rect.minX, y: rect.maxY)
    }

    
    private func bottomRightPoint(in rect: CGRect) -> CGPoint {
        CGPoint(x: rect.maxX, y: rect.maxY)
    }
}
