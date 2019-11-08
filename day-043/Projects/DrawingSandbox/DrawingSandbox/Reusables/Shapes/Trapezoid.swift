//
//  Trapezoid.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//


import SwiftUI


struct Trapezoid {
    
    // The amount by which the trapezoid's top points lean inward from
    // its bounds
    var insetAmount: CGFloat = 0.0
}


// MARK: - Shape
extension Trapezoid: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: bottomLeftPoint(in: rect))
        path.addLine(to: topLeftPoint(in: rect))
        path.addLine(to: topRightPoint(in: rect))
        path.addLine(to: bottomRightPoint(in: rect))
        path.addLine(to: bottomLeftPoint(in: rect))
        
        return path
    }
}


// MARK: - Computeds
extension Trapezoid {
    
    func bottomLeftPoint(in rect: CGRect) -> CGPoint {
        CGPoint(x: rect.minX, y: rect.maxY)
    }
    
    func topLeftPoint(in rect: CGRect) -> CGPoint {
        CGPoint(x: rect.minX + insetAmount, y: rect.minY)
    }
    
    func topRightPoint(in rect: CGRect) -> CGPoint {
        CGPoint(x: rect.maxX - insetAmount, y: rect.minY)
    }
    
    func bottomRightPoint(in rect: CGRect) -> CGPoint {
        CGPoint(x: rect.maxX, y: rect.maxY)
    }
}


// MARK: - Animatable Data
extension Trapezoid {
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { insetAmount = newValue }
    }
}
